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
        public string AddWord(string newWord)
        {
            using (var context = new FSOSSContext())
            {
                newWord = newWord.ToLower();
                string message = "";
                try
                {
                    var potentialSurveyWordList = from x in context.PotentialSurveyWords
                                                    where x.survey_access_word.ToLower().Equals(newWord.ToLower())
                                                    select new PotentialSurveyWordPOCO()
                                                    {
                                                        surveyWord = x.survey_access_word
                                                    };

                    if (potentialSurveyWordList.Count() > 0)
                    {
                        message = "The word \"" + newWord.ToLower() + "\" already exists. Please choose another word.";
                    }
                    else
                    {
                        PotentialSurveyWord potentialSurveyWord = new PotentialSurveyWord();
                        // to be set once the admin security is working
                        potentialSurveyWord.administrator_account_id = 1;
                        potentialSurveyWord.survey_access_word = newWord.Trim();
                        potentialSurveyWord.date_modified = DateTime.Now;
                        context.PotentialSurveyWords.Add(potentialSurveyWord);
                        context.SaveChanges();
                        message = "Successfully added the new survey word: \"" + newWord + "\"";
                    }
                }
                catch (Exception e)
                {
                    message = "Oops, something went wrong. Check " + e.Message;
                }
                return message;

            } 
        } 

        /// <summary>
        /// Method used to update a survey word from the list
        /// </summary>
        /// <param name="surveyWord"></param>
        /// <param name="surveyWordID"></param>
        /// <returns>returns confirmation message</returns>
        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public string UpdateWord(string surveyWord, int surveyWordID)
        {
            using (var context = new FSOSSContext())
            {
                surveyWord = surveyWord.ToLower();
                Regex validWord = new Regex("^[a-zA-Z]+$");
                string message = "";
                bool inUse = false;
                try
                {
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
                        wordToUpdate.survey_access_word = surveyWord.Trim();
                        wordToUpdate.date_modified = DateTime.Now;
                        context.Entry(wordToUpdate).Property(y => y.survey_access_word).IsModified = true;
                        context.Entry(wordToUpdate).Property(y => y.date_modified).IsModified = true;
                        context.SaveChanges();
                    }
                    else
                    {
                        throw new Exception("Word is currently use. Update failed.");
                    }
                }
                catch (Exception e)
                {
                    message = e.Message;
                }
                return message;
            }
        }

        /// <summary>
        /// Method used to disable words from the list that is used in the potential access words
        /// </summary>
        /// <param name="surveyWordID"></param>
        /// <returns>return confirmation message</returns>
        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public string DisableWord(int surveyWordID)
        {
            using (var context = new FSOSSContext())
            {
                string message = "";
                try
                {
                    // Check if the current word is in use
                    var surveyWordAttachToHospital = (from x in context.SurveyWords
                                                      where x.survey_word_id == surveyWordID
                                                      select new SurveyWordPOCO()
                                                      {
                                                             siteID = x.site_id,
                                                             surveyWordID = x.survey_word_id,
                                                           dateUsed = x.date_used
                                                         
                                                      }).FirstOrDefault();

                    if (surveyWordAttachToHospital == null)
                    {
                        PotentialSurveyWord potentialSurveyWord = context.PotentialSurveyWords.Find(surveyWordID);
                        potentialSurveyWord.archive_yn = true;
                        context.Entry(potentialSurveyWord).Property(y => y.archive_yn).IsModified = true;
                        context.SaveChanges();
                    }
                    else
                    {
                        throw new Exception("Unable to archive selected word. Word is currently in use.");
                    }                                                       
                }
                catch (Exception e)
                {
                    throw new Exception("Something went wrong. See " + e.Message);
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
        public List<PotentialSurveyWordPOCO> GetActiveSurveyWord(string surveyWord)
        {
            using (var context = new FSOSSContext())
            {

                try
                {

                    var potentialSurveyWordList = from x in context.PotentialSurveyWords
                                                  orderby x.survey_access_word
                                                  where x.survey_access_word.Contains(surveyWord.Trim()) && x.archive_yn == false
                                                  select new PotentialSurveyWordPOCO()
                                                  {
                                                      surveyWordID = x.survey_word_id,
                                                      surveyWord = x.survey_access_word
                                                  };

                    return potentialSurveyWordList.ToList();


                }
                catch (Exception e)
                {
                    throw new Exception("Something went wrong. See " + e.Message);
                }

            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="surveyWord"></param>
        /// <returns>potentialSurveyWordList</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<PotentialSurveyWordPOCO> GetArchivedSurveyWord(string surveyWord)
        {
            using (var context = new FSOSSContext())
            {

                try
                {

                    var potentialSurveyWordList = from x in context.PotentialSurveyWords
                                                  orderby x.survey_access_word
                                                  where x.survey_access_word.Contains(surveyWord.Trim()) && x.archive_yn == true
                                                  select new PotentialSurveyWordPOCO()
                                                  {
                                                      surveyWordID = x.survey_word_id,
                                                      surveyWord = x.survey_access_word
                                                  };

                    return potentialSurveyWordList.ToList();


                }
                catch (Exception e)
                {
                    throw new Exception("Something went wrong. See " + e.Message);
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
                                                  where x.archive_yn == false
                                                  select new PotentialSurveyWordPOCO()
                                                  {
                                                      surveyWordID = x.survey_word_id,
                                                      surveyWord = x.survey_access_word
                                                  };

                    return potentialSurveyWordList.ToList();


                }
                catch (Exception e)
                {
                    throw new Exception("Something went wrong. See " + e.Message);
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
                                                  where x.archive_yn == true
                                                  select new PotentialSurveyWordPOCO()
                                                  {
                                                      surveyWordID = x.survey_word_id,
                                                      surveyWord = x.survey_access_word
                                                  };

                    return potentialSurveyWordList.ToList();


                }
                catch (Exception e)
                {
                    throw new Exception("Something went wrong. See " + e.Message);
                }

            }
        }
    }
}
