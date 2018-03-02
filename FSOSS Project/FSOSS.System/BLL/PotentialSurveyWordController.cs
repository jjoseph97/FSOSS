﻿using System;
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
        //Add new Potential Word
        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public string AddWord(string newWord)
        {
            // transaction start
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
                            potentialSurveyWord.user_id = 1;
                            potentialSurveyWord.survey_access_word = newWord;
                            context.PotentialSurveyWords.Add(potentialSurveyWord);
                            context.SaveChanges();
                            message = "Successfully Added a New Word!";
                        }
                    }
                }
                catch (Exception e)
                {
                    message = "Oops, something went wrong. Check " + e.Message;
                }
                return message;

            } //end of transaction
        } // end of method AddWord

        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public string UpdateWord(string surveyWord, int surveyWordID)
        {
            using (var context = new FSOSSContext())
            {
                string message = "";
                try
                {
                    var wordToUpdate = context.PotentialSurveyWords.Find(surveyWordID);

                    //Not sure if update works with default constraint. Subject for testing
                    wordToUpdate.survey_access_word = surveyWord;
                    wordToUpdate.date_modified = DateTime.Now;
                    context.SaveChanges();

                    message = "Successfully Updated the Word!";
                }
                catch (Exception e)
                {
                    message = "Oops, something went wrong. Check " + e.Message;
                }
                return message;
            }
        }

        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public string DeleteWord(int surveyWordID)
        {
            using (var context = new FSOSSContext())
            {
                string message = "";
                try
                {

                    PotentialSurveyWord potentialSurveyWord = context.PotentialSurveyWords.Find(surveyWordID);
                    context.PotentialSurveyWords.Remove(potentialSurveyWord);
                    context.SaveChanges();


                    message = "Succesfully Remove Survey Word";
                    return message;


                }
                catch (Exception e)
                {
                    throw new Exception("Something went wrong. See " + e.Message);
                }

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
