using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
#region
using FSOSS.System.Data.POCOs;
using FSOSS.System.Data.Entity;
using FSOSS.System.DAL;
using Hangfire;
#endregion
namespace FSOSS.System.BLL
{
    public class SurveyWordController
    {
        /// <summary>
        /// Method use to generate random survey word of the day from the list of potential survey words. 
        /// Perform validation and checks to ensure that the surveyword of the day doesn't repeat. 
        /// Remove few old survey words once all the words are being used. 
        /// </summary>
        public void GenerateSurveyWordOfTheDay()
        {
            // Start of Transaction
            using (var context = new FSOSSContext())
            {
                //Get the list of survey word in the database
                List<SurveyWord> surveyWordList = (from x in context.SurveyWords
                                                   select x).ToList();
                //Get the list of potential survey word which is currently active
                List<PotentialSurveyWord> potentialSurveyWordList = (from x in context.PotentialSurveyWords
                                                                     where x.archived_yn == false
                                                                     select x).ToList();
                //Get the list of all site to be added
                List<Site> siteList = (from x in context.Sites
                                       select x).ToList();
                // Check if theres enough active Potential Survey Word on the list
                if (siteList.Count > potentialSurveyWordList.Count())
                {
                    // Throw an exception if there are not enough survey word on the pool to be use on the list
                    throw new Exception("Please add more potential survey word. Not enough potential survey word available to be assign on the hospitals.");
                }
                else
                {
                    //Check if all potential survey word is used
                    if (surveyWordList.Count >= potentialSurveyWordList.Count)
                    {
                        List<SurveyWord> newSurveyListForCheck = null;
                        do
                        {
                            // Get the fresh list of survey words
                            newSurveyListForCheck = (from x in context.SurveyWords
                                                     select x).ToList();

                            //Get the last Survey Word by date
                            SurveyWord surveyWord = (from x in context.SurveyWords
                                                     orderby x.date_used
                                                     select x).FirstOrDefault();
                            //Remove the last Survey Word 
                            context.SurveyWords.Remove(surveyWord);
                            context.SaveChanges();
                            surveyWord = null;

                            //Check if the there are enough Potential Survey word available from the List in the database to be used for all the hospital
                            //Repeat the step above until theres enough potentail word to lookupon
                        } while (newSurveyListForCheck.Count() < potentialSurveyWordList.Count() - siteList.Count());
                    }
                    //Create an instance of Random Object
                    Random random = new Random();
                    //Create a variable to hold the potential survey word to be used
                    PotentialSurveyWord surveyWordToAdd = null;
                    foreach (Site site in siteList)
                    {
                        //Boolean use to check if the word exists;
                        bool wordIsUsed = true;
                        //Loop that will run until a random word is choosen that doesn't exists on the current Survey Word Table
                        do
                        {
                            // Get a fresh list of survey words
                            List<SurveyWord> newSurveyWordList = (from x in context.SurveyWords
                                                                  select x).ToList();
                            //Generate Random Number
                            int randomIndex = random.Next(0, potentialSurveyWordList.Count());
                            //Get the PotentialSurveyWord to be added based on the index
                            surveyWordToAdd = potentialSurveyWordList.ElementAt(randomIndex);
                            //Loop through the List of current SurveyWord and check if the word has been used by the current site.
                            wordIsUsed = newSurveyWordList.Any(word => word.survey_word_id == surveyWordToAdd.survey_word_id);
                            //If the Word doesn't exists after the loop on Survey Word List. Exit on the loop else start the process all over again.
                        } while (wordIsUsed == true);

                        //Add SurveyWord after the validation
                        SurveyWord newSurveyWord = new SurveyWord()
                        {
                            date_used = DateTime.Now,
                            site_id = site.site_id,
                            survey_word_id = surveyWordToAdd.survey_word_id
                        };
                        // Load newSurveyWord to be saved
                        context.SurveyWords.Add(newSurveyWord);
                        // Save the new added Survey Word
                        context.SaveChanges();
                        // clear the survey word
                        newSurveyWord = null;
                    }
                }
                // Initialze current Date and Time
                DateTime currentDateTime = DateTime.Now;
                // Set timeOffset to be use to setup date and time for the next scheduled job.
                // Current setup will be set to fire at 12:00 midnight after one day 
                DateTime timeOffset = new DateTime(currentDateTime.Year, currentDateTime.Month, currentDateTime.Day + 1, 0, 0, 0);
                // Setup new job schedule that will fire GenerateSurveyWordOfTheDay after the given offset
                BackgroundJob.Schedule(() => GenerateSurveyWordOfTheDay(), timeOffset);
            }
        }

        /// <summary>
        /// Method is used to validate access word
        /// </summary>
        /// <param name="enteredWord"></param>
        /// <returns>Returns a boolean value that denotes if the word is in use for the current day</returns>
        public bool ValidateAccessWord(string enteredWord)
        {
            // Start of Transaction
            using (var context = new FSOSSContext())
            {
                // Return true if entered word exists and is in use for the current day; else return false
                return context.SurveyWords.Any(x => x.PotentialSurveyWord.survey_access_word.Equals(enteredWord) && x.date_used.Day == DateTime.Now.Day);
            }
        }

        /// <summary>
        /// Method use to get the Site object based on the survey word entered
        /// </summary>
        /// <param name="surveyWordEntered">Survey word entered by the participant</param>
        /// <returns>Return a Site object </returns>
        public Site GetSite(string surveyWordEntered)
        {
            //Start of Transaction
            using (var context = new FSOSSContext())
            {
                try
                {
                    // Get the survey word to check
                    SurveyWord surveyWordToCheck = (from x in context.SurveyWords
                                                    where x.PotentialSurveyWord.survey_access_word.Equals(surveyWordEntered)
                                                    select x).FirstOrDefault();
                    // Get the selected site associated with the survey word
                    Site selectedSite = (from x in context.Sites
                                         where x.site_id == surveyWordToCheck.site_id
                                         select x).FirstOrDefault();

                    return selectedSite;
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }
        /// <summary>
        /// Method use to get the survey word text 
        /// </summary>
        /// <param name="siteID">Site Id to identify what survey word to display</param>
        /// <returns>Return the survey word text</returns>
        public string GetSurveyWord(int siteID)
        {
            // Start of Transaction
            using (var context = new FSOSSContext())
            {
                string currentSurveyWord = (from x in context.SurveyWords
                                            where x.site_id == siteID && x.date_used.Day == DateTime.Now.Day
                                            orderby x.date_used descending
                                            select x.PotentialSurveyWord.survey_access_word).FirstOrDefault();
                return currentSurveyWord;
            }
        }
        /// <summary>
        /// Method use to assign a new survey word if a new Site is created 
        /// </summary>
        /// <param name="siteName"> Site Name of the new site created</param>
        public void NewSite_NewWord(string siteName)
        {
            // Start of Transaction
            using (var context = new FSOSSContext())
            {
                //grab the new site id,
                int siteId = (from x in context.Sites
                              where x.site_name.Equals(siteName) && x.archived_yn == false
                              select x.site_id).FirstOrDefault();

                //get all the active words
                List<PotentialSurveyWord> potentialSurveyWordList = (from x in context.PotentialSurveyWords
                                                                     where x.archived_yn == false
                                                                     select x).ToList();
                //get all the surveywords
                List<SurveyWord> surveyWordList = (from x in context.SurveyWords
                                                   select x).ToList();
                // If the count of survey words being used
                if (surveyWordList.Count >= potentialSurveyWordList.Count)
                {
                    SurveyWord wordToBeRemoved = (from x in context.SurveyWords
                                                  orderby x.date_used
                                                  select x).FirstOrDefault();
                    context.SurveyWords.Remove(wordToBeRemoved);
                    context.SaveChanges();
                }
                Random random = new Random();
                bool wordIsUsed = true;
                PotentialSurveyWord surveyWordToAdd = null;

                do
                {
                    List<SurveyWord> newSurveyWordList = (from x in context.SurveyWords
                                                          select x).ToList();
                    int randomIndex = random.Next(0, potentialSurveyWordList.Count());
                    surveyWordToAdd = potentialSurveyWordList.ElementAt(randomIndex);
                    wordIsUsed = newSurveyWordList.Any(word => word.survey_word_id == surveyWordToAdd.survey_word_id);
                } while (wordIsUsed == true);

                SurveyWord newSurveyWord = new SurveyWord()
                {
                    date_used = DateTime.Now,
                    site_id = siteId,
                    survey_word_id = surveyWordToAdd.survey_word_id
                };
                context.SurveyWords.Add(newSurveyWord);
                context.SaveChanges();

            }
        }

        /// <summary>
        /// Method used to get a count of all survey words being used.
        /// </summary>
        /// <returns></returns>
        public int GetSurveyWordCount()
        {
            using (var context = new FSOSSContext())
            {
                var result = from x in context.SurveyWords
                             select x;

                return result.ToList().Count();
            }
        }

        /// <summary>
        /// Method use to manually generate random survey word of the day for the selected Site.
        /// Perform validation and checks to ensure that the surveyword of the day doesn't repeat. 
        /// </summary>
        /// <param name="siteId"></param>
        public void ManuallyGeneratedSurveyWord(int siteId)
        {
            using (var context = new FSOSSContext())
            {
                // Get the assigned word for the selected Site for the current day
                SurveyWord wordToRemove = (from x in context.SurveyWords
                                           where x.date_used.Day == DateTime.Now.Day && x.site_id == siteId
                                           select x).FirstOrDefault();

                // If there is already an assigned word to the selected Site
                if (wordToRemove != null)
                {
                    // Remove the existing word
                    context.SurveyWords.Remove(wordToRemove);
                    context.SaveChanges();
                }


                //Create an instance of Random Object
                Random random = new Random();
                //Create a variable to hold the potential survey word to be used
                PotentialSurveyWord surveyWordToAdd = null;
                //Get the list of potential survey word which is currently active
                List<PotentialSurveyWord> potentialSurveyWordList = (from x in context.PotentialSurveyWords
                                                                     where x.archived_yn == false
                                                                     select x).ToList();
                //Boolean use to check if the word exists;
                bool wordIsUsed = true;
                //Loop that will run until a random word is choosen that doesn't exists on the current Survey Word Table
                do
                {
                    // Get a fresh list of survey words
                    List<SurveyWord> newSurveyWordList = (from x in context.SurveyWords
                                                          select x).ToList();
                    //Generate Random Number
                    int randomIndex = random.Next(0, potentialSurveyWordList.Count());
                    //Get the PotentialSurveyWord to be added based on the index
                    surveyWordToAdd = potentialSurveyWordList.ElementAt(randomIndex);
                    //Loop through the List of current SurveyWord and check if the word has been used by the current site.
                    wordIsUsed = newSurveyWordList.Any(word => word.survey_word_id == surveyWordToAdd.survey_word_id);
                    //If the Word doesn't exists after the loop on Survey Word List. Exit on the loop else start the process all over again.
                } while (wordIsUsed == true);
                //Add SurveyWord after the validation
                SurveyWord newSurveyWord = new SurveyWord()
                {
                    date_used = DateTime.Now,
                    site_id = siteId,
                    survey_word_id = surveyWordToAdd.survey_word_id
                };
                // Load newSurveyWord to be saved
                context.SurveyWords.Add(newSurveyWord);
                // Save the new added Survey Word
                context.SaveChanges();
                // clear the survey word
                newSurveyWord = null;
            }
        }
    }

}

