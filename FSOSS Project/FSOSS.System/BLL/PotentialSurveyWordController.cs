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
        /// Method used to add a new potential survey word to the list
        /// </summary>
        /// <param name="newWord"></param>
        /// <returns>returns confirmation from the list</returns>
        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public void AddWord(string newWord, int userID)
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    newWord = newWord.ToLower();
                    Regex validWord = new Regex("^[a-zA-Z]+$");

                    var potentialSurveyWordList = from x in context.PotentialSurveyWords
                                                  where x.survey_access_word.ToLower().Equals(newWord.ToLower())
                                                  select new PotentialSurveyWordPOCO()
                                                  {
                                                      surveyWord = x.survey_access_word
                                                  };

                    if (potentialSurveyWordList.Count() > 0)
                    {
                        throw new Exception("The word \"" + newWord.ToLower() + "\" already exists. Please choose another word.");
                    }
                    else
                    {
                        if (newWord == "" || newWord == null)
                        {
                            throw new Exception("You must type in a word to add. Field cannot be empty.");
                        }
                        else if (!validWord.IsMatch(newWord))
                        {
                            throw new Exception("Please enter only alphabetical letters and no spaces.");
                        }
                        else if (newWord.Length < 4 || newWord.Length > 8)
                        {
                            throw new Exception("New survey word must be between 4 to 8 characters characters in length.");
                        }
                        else
                        {
                            PotentialSurveyWord potentialSurveyWord = new PotentialSurveyWord();
                            potentialSurveyWord.administrator_account_id = userID;
                            potentialSurveyWord.survey_access_word = newWord.Trim();
                            potentialSurveyWord.date_modified = DateTime.Now;
                            context.PotentialSurveyWords.Add(potentialSurveyWord);
                            context.SaveChanges();
                        }
                    }
                }
                catch (Exception e)
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
        /// <returns>returns confirmation message</returns>
        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public string UpdateWord(string surveyWord, int surveyWordID, int userID)
        {
            using (var context = new FSOSSContext())
            {
                string message = "";
                try
                {
                    if (surveyWord == "" || surveyWord == null)
                    {
                        throw new Exception("Edit field cannot be blank. You must enter a word between 4 to 8 characters in length.");
                    }
                    else
                    {
                        surveyWord = surveyWord.ToLower().Trim();
                    }
                    Regex validWord = new Regex("^[a-zA-Z]+$");

                    var potentialSurveyWordList = from x in context.PotentialSurveyWords
                                                  where x.survey_access_word.ToLower().Equals(surveyWord.ToLower())
                                                  select new PotentialSurveyWordPOCO()
                                                  {
                                                      surveyWord = x.survey_access_word
                                                  };

                    if (potentialSurveyWordList.Count() > 0)
                    {
                        throw new Exception("The word \"" + surveyWord.ToLower() + "\" already exists. Please choose another word.");
                    }
                    else
                    {
                        if (surveyWord.Length < 4 || surveyWord.Length > 8)
                        {
                            throw new Exception("Updated survey word must be between 4 to 8 characters in length.");
                        }
                        else if (!validWord.IsMatch(surveyWord))
                        {
                            throw new Exception("Please enter only alphabetical letters and no spaces.");
                        }
                        else
                        {
                            bool inUse = false;

                            var surveyWordList = (from x in context.SurveyWords
                                                  select new SurveyWordPOCO
                                                  {
                                                      siteID = x.site_id,
                                                      dateUsed = x.date_used,
                                                      surveyWordID = x.survey_word_id
                                                  }).ToList();


                            foreach (SurveyWordPOCO item in surveyWordList)
                            {
                                if (item.surveyWordID == surveyWordID && item.dateUsed == DateTime.Now)
                                {
                                    inUse = true;
                                    break;
                                }
                            }

                            if (validWord.IsMatch(surveyWord) && inUse == false)
                            {
                                var wordToUpdate = context.PotentialSurveyWords.Find(surveyWordID);
                                wordToUpdate.administrator_account_id = userID;
                                wordToUpdate.survey_access_word = surveyWord.Trim();
                                wordToUpdate.date_modified = DateTime.Now;
                                context.Entry(wordToUpdate).Property(y => y.administrator_account_id).IsModified = true;
                                context.Entry(wordToUpdate).Property(y => y.survey_access_word).IsModified = true;
                                context.Entry(wordToUpdate).Property(y => y.date_modified).IsModified = true;
                                context.SaveChanges();

                                message = "The survey word has been updated to \"" + surveyWord + "\".";
                            }
                            else
                            {
                                throw new Exception("Unable to update the selected word. Word is currently in use.");
                            }

                        }
                    }
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
                return message;
            }
        }

        /// <summary>
        /// Method used to disable or enable words from the list that is used in the potential access words
        /// </summary>
        /// <param name="surveyWordID"></param>
        /// <returns>return confirmation message</returns>
        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public string ChangeAvailability(int surveyWordID, int userID)
        {
            using (var context = new FSOSSContext())
            {
                string message = "";
                try
                {
                    // Get the current date.
                    DateTime dateTime = DateTime.Today;
                    // Check if the current word is in use by checking todays date against the words in the database
                    var surveyWordAttachToHospital = (from x in context.SurveyWords
                                                      where x.date_used.Day == dateTime.Day
                                                      select new SurveyWordPOCO()
                                                      {
                                                          siteID = x.site_id,
                                                          surveyWordID = x.survey_word_id,
                                                          dateUsed = x.date_used

                                                      }).FirstOrDefault();

                    if (surveyWordAttachToHospital == null)
                    {
                        PotentialSurveyWord potentialSurveyWord = context.PotentialSurveyWords.Find(surveyWordID);
                        if (potentialSurveyWord.archived_yn == true)
                        {
                            potentialSurveyWord.archived_yn = false;
                        }
                        else if (potentialSurveyWord.archived_yn == false)
                        {
                            potentialSurveyWord.archived_yn = true;
                        }
                        potentialSurveyWord.administrator_account_id = userID;
                        potentialSurveyWord.date_modified = DateTime.Now;
                        context.Entry(potentialSurveyWord).Property(y => y.administrator_account_id).IsModified = true;
                        context.Entry(potentialSurveyWord).Property(y => y.archived_yn).IsModified = true;
                        context.Entry(potentialSurveyWord).Property(y => y.date_modified).IsModified = true;
                        context.SaveChanges();
                        message = "Successfully changed availability on the survey word.";
                    }
                    else
                    {
                        throw new Exception("Unable to changed availability of the selected word. Word is currently in use.");
                    }
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
                return message;
            }
        }

        /// <summary>
        /// 
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

                    var potentialSurveyWordList = from x in context.PotentialSurveyWords
                                                  orderby x.survey_access_word
                                                  where x.survey_access_word.Contains(surveyWord.Trim()) && x.archived_yn == false
                                                  select new PotentialSurveyWordPOCO()
                                                  {
                                                      surveyWordID = x.survey_word_id,
                                                      surveyWord = x.survey_access_word
                                                  };

                    return potentialSurveyWordList.ToList();


                }
                catch (Exception e)
                {
                    throw new Exception("Please contact the Administrator with the error message: " + e.Message);
                }

            }
        }

        /// <summary>
        /// 
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

                    var potentialSurveyWordList = from x in context.PotentialSurveyWords
                                                  orderby x.survey_access_word
                                                  where x.survey_access_word.Contains(surveyWord.Trim()) && x.archived_yn == true
                                                  select new PotentialSurveyWordPOCO()
                                                  {
                                                      surveyWordID = x.survey_word_id,
                                                      surveyWord = x.survey_access_word
                                                  };

                    return potentialSurveyWordList.ToList();


                }
                catch (Exception e)
                {
                    throw new Exception("Please contact the Administrator with the error message: " + e.Message);
                }

            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns>potentialSurveyWordList</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<PotentialSurveyWordPOCO> GetActiveSurveyWord()
        {
            using (var context = new FSOSSContext())
            {

                try
                {

                    var potentialSurveyWordList = from x in context.PotentialSurveyWords
                                                  orderby x.survey_access_word
                                                  where x.archived_yn == false
                                                  select new PotentialSurveyWordPOCO()
                                                  {
                                                      surveyWordID = x.survey_word_id,
                                                      surveyWord = x.survey_access_word
                                                  };

                    return potentialSurveyWordList.ToList();


                }
                catch (Exception e)
                {
                    throw new Exception("Please contact the Administrator with the error message: " + e.Message);
                }

            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns>potentialSurveyWordList</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<PotentialSurveyWordPOCO> GetArchivedSurveyWord()
        {
            using (var context = new FSOSSContext())
            {

                try
                {

                    var potentialSurveyWordList = from x in context.PotentialSurveyWords
                                                  orderby x.survey_access_word
                                                  where x.archived_yn == true
                                                  select new PotentialSurveyWordPOCO()
                                                  {
                                                      surveyWordID = x.survey_word_id,
                                                      surveyWord = x.survey_access_word
                                                  };

                    return potentialSurveyWordList.ToList();


                }
                catch (Exception e)
                {
                    throw new Exception("Please contact the Administrator with the error message: " + e.Message);
                }

            }
        }
    }
}
