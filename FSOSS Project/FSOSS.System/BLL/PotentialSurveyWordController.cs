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
#endregion

namespace FSOSS.System.BLL
{
    [DataObject]
    public class PotentialSurveyWordController
    {
        /// <summary>
        /// Method use to add new potential survey word to the list
        /// </summary>
        /// <param name="newWord"></param>
        /// <returns>returns confirmation from the list</returns>
        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public string AddWord(string newWord)
        {
            using (var context = new FSOSSContext())
            {
                string message = "";
                try
                {
                    if (newWord == "" || newWord == null)
                    {
                        message = "Cannot be empty";
                    }
                    else
                    {
                        var potentialSurveyWordList = from x in context.PotentialSurveyWords
                                                      where x.survey_access_word.ToLower().Contains(newWord.ToLower())
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
                            potentialSurveyWord.survey_access_word = newWord;
                            context.PotentialSurveyWords.Add(potentialSurveyWord);
                            context.SaveChanges();
                        }
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
        /// Method use to update word from the list
        /// </summary>
        /// <param name="surveyWord"></param>
        /// <param name="surveyWordID"></param>
        /// <returns>returns confirmation message</returns>
        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public string UpdateWord(string surveyWord, int surveyWordID)
        {
            using (var context = new FSOSSContext())
            {
                string message = "";
                try
                {
                    var wordToUpdate = context.PotentialSurveyWords.Find(surveyWordID);
                    wordToUpdate.survey_access_word = surveyWord;
                    wordToUpdate.date_modified = DateTime.Now;
                    context.SaveChanges();
                }
                catch (Exception e)
                {
                    message = e.Message;
                }
                return message;
            }
        }

        /// <summary>
        /// Method use to delete words from the list that is use in the potential access words
        /// </summary>
        /// <param name="surveyWordID"></param>
        /// <returns>return confirmation message</returns>
        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public string DeleteWord(int surveyWordID)
        {
            using (var context = new FSOSSContext())
            {
                string message = "";
                try
                {
                   // Deletes all the data from the child SurveyWord entity
                    var surveyWord = (from x in context.SurveyWords
                                      where x.survey_word_id == surveyWordID
                                      select new SurveyWordPOCO()
                                      {
                                          surveyWordID = x.survey_word_id,
                                          siteID = x.site_id,
                                          dateUsed = x.date_used
                                     }).ToList();

                    if(surveyWord.Count > 0)
                    {
                        foreach (SurveyWordPOCO surveyWordInstance in surveyWord)
                        {
                            SurveyWord wordForRemoval = context.SurveyWords.Find(surveyWordInstance.surveyWordID);
                            context.SurveyWords.Remove(wordForRemoval);
                            context.SaveChanges();
                        }
                    }
                    PotentialSurveyWord potentialSurveyWord = context.PotentialSurveyWords.Find(surveyWordID);
                    context.PotentialSurveyWords.Remove(potentialSurveyWord);
                    context.SaveChanges();
                }
                catch (Exception e)
                {
                    throw new Exception("Something went wrong. See " + e.Message);
                }
                return message;
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<PotentialSurveyWordPOCO> GetSurveyWord(string surveyWord)
        {
            using (var context = new FSOSSContext())
            {

                try
                {

                    var potentialSurveyWordList = from x in context.PotentialSurveyWords
                                                  orderby x.survey_word_id
                                                  where x.survey_access_word.Contains("/" + surveyWord + "/")
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

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<PotentialSurveyWordPOCO> GetAllSurveyWord()
        {
            using (var context = new FSOSSContext())
            {

                try
                {

                    var potentialSurveyWordList = from x in context.PotentialSurveyWords
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
