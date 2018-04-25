using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region
using System.ComponentModel;
using FSOSS.System.Data.Entity;
using FSOSS.System.DAL;
using FSOSS.System.Data.POCOs;
using System.Text.RegularExpressions;
#endregion

namespace FSOSS.System.BLL
{
    [DataObject]
    public class PotentialSurveyWordController
    {
        /// <summary>
        /// Method used to add a new potential survey word to the database
        /// </summary>
        /// <param name="newWord"></param>
        /// <param name="adminID"></param>
        /// <returns>returns confirmation from the list</returns>
        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public void AddWord(string newWord, int adminID)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    Regex validWord = new Regex("^[a-zA-Z]+$");

                    // gets a list of survey words where the newWord is matching an existing word
                    var potentialSurveyWordList = from x in context.PotentialSurveyWords
                                                  where x.survey_access_word.ToLower().Equals(newWord.ToLower())
                                                  select new PotentialSurveyWordPOCO()
                                                  {
                                                      surveyWord = x.survey_access_word
                                                  };

                    if (potentialSurveyWordList.Count() > 0) // if a survey word was found display an error that the word already exists
                    {
                        throw new Exception("The word \"" + newWord.ToLower() + "\" already exists. Please choose another word.");
                    }
                    else
                    {
                        if (newWord == "" || newWord == null) // if no survey word was entered, display an error
                        {
                            throw new Exception("You must type in a word to add. Field cannot be empty.");
                        }
                        else if (!validWord.IsMatch(newWord)) // if the survey word entered is not valid (no special characters, spaces, or numbers), display an error
                        {
                            throw new Exception("Please enter only alphabetical letters and no spaces.");
                        }
                        else if (newWord.Length < 4 || newWord.Length > 8)  // if the survey word is not the correct length (between 4 and 8 characters), display an error
                        {
                            throw new Exception("New survey word must be between 4 to 8 characters characters in length.");
                        }
                        else // else, add the new survey word, the current date and admin ID from the admin that is logged in to the potential survey word table in the database
                        {
                            PotentialSurveyWord potentialSurveyWord = new PotentialSurveyWord();
                            potentialSurveyWord.administrator_account_id = adminID;
                            potentialSurveyWord.survey_access_word = newWord.Trim();
                            potentialSurveyWord.date_modified = DateTime.Now;
                            context.PotentialSurveyWords.Add(potentialSurveyWord);
                            context.SaveChanges();
                        }
                    }
                }
                catch (Exception e) // catch the error and display it on the page with MessageUserControl
                {
                    throw new Exception(e.Message);
                }
            }
        }

        /// <summary>
        /// Method used to update a survey word from the list
        /// </summary>
        /// <param name="surveyWord"></param>
        /// <param name="surveyWordID"></param>
        /// <param name="adminID"></param>
        /// <returns>returns confirmation message</returns>
        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public string UpdateWord(string surveyWord, int surveyWordID, int adminID)
        {
            using (var context = new FSOSSContext())
            {
                string message = "";
                try
                {
                    surveyWord = surveyWord.ToLower().Trim(); // trim the spaces and covert the updated survey word to lowercase
                    Regex validWord = new Regex("^[a-zA-Z]+$");

                    // gets a list of survey words where the surveyWord is matching an existing word
                    var potentialSurveyWordList = from x in context.PotentialSurveyWords
                                                  where x.survey_access_word.ToLower().Equals(surveyWord)
                                                  select new PotentialSurveyWordPOCO()
                                                  {
                                                      surveyWord = x.survey_access_word
                                                  };

                    if (potentialSurveyWordList.Count() > 0) // if a survey word was found display an error that the word already exists
                    {
                        throw new Exception("The word \"" + surveyWord + "\" already exists. Please update to a different word.");
                    }
                    else
                    {
                        if (surveyWord == "" || surveyWord == null) // if no survey word was entered, display an error
                        {
                            throw new Exception("Edit field cannot be blank. You must enter a word between 4 to 8 characters in length.");
                        }
                        else if (!validWord.IsMatch(surveyWord)) // if the survey word entered is not valid (no special characters, spaces, or numbers), display an error
                        {
                            throw new Exception("Please enter only alphabetical letters and no spaces.");
                        }
                        else if (surveyWord.Length < 4 || surveyWord.Length > 8) // if the survey word is not the correct length (between 4 and 8 characters), display an error
                        {
                            throw new Exception("Updated survey word must be between 4 to 8 characters in length.");
                        }
                        else
                        {
                            bool inUse = false;

                            // gets a list of survey word IDs and the date that the words are in use 
                            var surveyWordList = (from x in context.SurveyWords
                                                  select new SurveyWordPOCO
                                                  {
                                                      dateUsed = x.date_used,
                                                      surveyWordID = x.survey_word_id
                                                  }).ToList();


                            foreach (SurveyWordPOCO item in surveyWordList) // loop through the survey word list and match the survey word ID and the date used to todays date
                            {
                                if (item.surveyWordID == surveyWordID && item.dateUsed.Day == DateTime.Today.Day)
                                {
                                    inUse = true; // toggle inUse to true if the survey word is in use today
                                    break;
                                }
                            }

                            if (validWord.IsMatch(surveyWord) && inUse == false) // if the survey word is not in use today, then update the survey word, the modified date and user ID from the user that is logged in to the potential survey word table in the database
                            {
                                var wordToUpdate = context.PotentialSurveyWords.Find(surveyWordID);
                                wordToUpdate.administrator_account_id = adminID;
                                wordToUpdate.survey_access_word = surveyWord.Trim();
                                wordToUpdate.date_modified = DateTime.Now;
                                context.Entry(wordToUpdate).Property(y => y.administrator_account_id).IsModified = true;
                                context.Entry(wordToUpdate).Property(y => y.survey_access_word).IsModified = true;
                                context.Entry(wordToUpdate).Property(y => y.date_modified).IsModified = true;
                                context.SaveChanges();

                                message = "The survey word has been updated to \"" + surveyWord + "\"."; // update message to display a success message
                            }
                            else
                            {
                                throw new Exception("Unable to update the selected word. Word is currently in use.");
                            }
                        }
                    }
                }
                catch (Exception e) // catch the error and display it on the page with MessageUserControl
                {
                    throw new Exception(e.Message);
                }
                return message; // return the success message
            }
        }

        /// <summary>
        /// Method used to disable or enable words from the list that is used in the potential access words
        /// </summary>
        /// <param name="surveyWordID"></param>
        /// <param name="adminID"></param>
        /// <returns>return confirmation message</returns>
        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public string ChangeAvailability(int surveyWordID, int adminID)
        {
            using (var context = new FSOSSContext())
            {
                string message = "";
                try
                {
                    // get the current date
                    DateTime dateTime = DateTime.Today;

                    // check if the current word is in use by matching the correct survey word ID and then checking todays day/month/year against the survey word in the database to see if it is in use today
                    var surveyWordAttachToHospital = (from x in context.SurveyWords
                                                      where x.PotentialSurveyWord.survey_word_id == surveyWordID && x.date_used.Day == dateTime.Day && x.date_used.Month == dateTime.Month && x.date_used.Year == dateTime.Year
                                                      select new SurveyWordPOCO()
                                                      {
                                                          siteID = x.site_id,
                                                          surveyWordID = x.survey_word_id,
                                                          dateUsed = x.date_used

                                                      }).FirstOrDefault();

                    if (surveyWordAttachToHospital == null) // if surveyWordAttachToHospital is null, it is not in use and can be disabled or enabled
                    {
                        PotentialSurveyWord potentialSurveyWord = context.PotentialSurveyWords.Find(surveyWordID); // find the survey word by matching it with the survey word ID
                        if (potentialSurveyWord.archived_yn == true) // if the survey word is archived, toggle the archived boolean to false and display the success message that it has been enabled
                        {
                            potentialSurveyWord.archived_yn = false;
                            message = "Successfully enabled the survey word.";
                        }
                        else if (potentialSurveyWord.archived_yn == false) // if the survey word is active, toggle the archived boolean to true and display the success message that it has been disabled
                        {
                            potentialSurveyWord.archived_yn = true;
                            message = "Successfully disabled the survey word.";
                        }
                        // now update the survey word to either enabled or disabled, the modified date and admin ID from the admin that is logged in to the potential survey word table in the database
                        potentialSurveyWord.administrator_account_id = adminID;
                        potentialSurveyWord.date_modified = DateTime.Now;
                        context.Entry(potentialSurveyWord).Property(y => y.administrator_account_id).IsModified = true;
                        context.Entry(potentialSurveyWord).Property(y => y.archived_yn).IsModified = true;
                        context.Entry(potentialSurveyWord).Property(y => y.date_modified).IsModified = true;
                        context.SaveChanges();
                    }
                    else
                    {
                        throw new Exception("Unable to change availability of the selected word. Word is currently in use.");
                    }
                }
                catch (Exception e) // catch the error and display it on the page with MessageUserControl
                {
                    throw new Exception(e.Message);
                }
                return message; // return the success message
            }
        }

        /// <summary>
        /// Used to get the active survey words for when the admin enters a search term to filter the list of words on the ChangeSurveyWord page
        /// </summary>
        /// <param name="surveyWord"></param>
        /// <returns>potentialSurveyWordList</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<PotentialSurveyWordPOCO> GetSearchedActiveSurveyWord(string surveyWord)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    // gets a list of survey word IDs, survey words, the date modified and the username from the potential survey words table where the survey word is matching the searched term and is not archived
                    var potentialSurveyWordList = from x in context.PotentialSurveyWords
                                                  orderby x.survey_access_word
                                                  where x.survey_access_word.Contains(surveyWord.Trim()) && x.archived_yn == false
                                                  select new PotentialSurveyWordPOCO()
                                                  {
                                                      surveyWordID = x.survey_word_id,
                                                      surveyWord = x.survey_access_word,
                                                      dateModified = x.date_modified,
                                                      username = x.AdministratorAccount.username
                                                  };

                    return potentialSurveyWordList.ToList();
                }
                catch (Exception e) // if anything goes wrong with retieving the survey words to a list, display an user-friendly error message
                {
                    throw new Exception("Please contact the Administrator with the error message: " + e.Message);
                }
            }
        }

        /// <summary>
        /// Used to get the archived survey words for when the admin enters a search term to filter the list of words on the ChangeSurveyWord page
        /// </summary>
        /// <param name="surveyWord"></param>
        /// <returns>potentialSurveyWordList</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<PotentialSurveyWordPOCO> GetSearchedArchivedSurveyWord(string surveyWord)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    // gets a list of survey word IDs, survey words, the date modified and the username from the potential survey words table where the survey word is matching the searched term and is archived
                    var potentialSurveyWordList = from x in context.PotentialSurveyWords
                                                  orderby x.survey_access_word
                                                  where x.survey_access_word.Contains(surveyWord.Trim()) && x.archived_yn == true
                                                  select new PotentialSurveyWordPOCO()
                                                  {
                                                      surveyWordID = x.survey_word_id,
                                                      surveyWord = x.survey_access_word,
                                                      dateModified = x.date_modified,
                                                      username = x.AdministratorAccount.username
                                                  };

                    return potentialSurveyWordList.ToList();
                }
                catch (Exception e) // if anything goes wrong with retieving the survey words to a list, display an user-friendly error message
                {
                    throw new Exception("Please contact the Administrator with the error message: " + e.Message);
                }
            }
        }

        /// <summary>
        /// Used to get all the active survey words and populate the list on the ChangeSurveyWord page
        /// </summary>
        /// <returns>potentialSurveyWordList</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<PotentialSurveyWordPOCO> GetActiveSurveyWord()
        {
            using (var context = new FSOSSContext())
            {

                try
                {
                    // gets a list of survey word IDs, survey words, the date modified and the username from the potential survey words table where the survey word is not archived
                    var potentialSurveyWordList = from x in context.PotentialSurveyWords
                                                  orderby x.survey_access_word
                                                  where x.archived_yn == false
                                                  select new PotentialSurveyWordPOCO()
                                                  {
                                                      surveyWordID = x.survey_word_id,
                                                      surveyWord = x.survey_access_word,
                                                      dateModified = x.date_modified,
                                                      username = x.AdministratorAccount.username
                                                  };

                    return potentialSurveyWordList.ToList();


                }
                catch (Exception e) // if anything goes wrong with retieving the survey words to a list, display an user-friendly error message
                {
                    throw new Exception("Please contact the Administrator with the error message: " + e.Message);
                }
            }
        }

        /// <summary>
        /// Used to get all the archived survey words and populate the list on the ChangeSurveyWord page
        /// </summary>
        /// <returns>potentialSurveyWordList</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<PotentialSurveyWordPOCO> GetArchivedSurveyWord()
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    // gets a list of survey word IDs, survey words, the date modified and the username from the potential survey words table where the survey word is archived
                    var potentialSurveyWordList = from x in context.PotentialSurveyWords
                                                  orderby x.survey_access_word
                                                  where x.archived_yn == true
                                                  select new PotentialSurveyWordPOCO()
                                                  {
                                                      surveyWordID = x.survey_word_id,
                                                      surveyWord = x.survey_access_word,
                                                      dateModified = x.date_modified,
                                                      username = x.AdministratorAccount.username
                                                  };

                    return potentialSurveyWordList.ToList();
                }
                catch (Exception e) // if anything goes wrong with retieving the survey words to a list, display an user-friendly error message
                {
                    throw new Exception("Please contact the Administrator with the error message: " + e.Message);
                }
            }
        }
    }
}
