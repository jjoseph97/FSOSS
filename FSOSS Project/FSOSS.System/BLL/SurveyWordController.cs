using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
#region
using FSOSS.System.Data.POCOs;
using FSOSS.System.Data.Entity;
using FSOSS.System.DAL;
#endregion
namespace FSOSS.System.BLL
{
    public class SurveyWordController
    {
        public void GenerateSurveyWordOfTheDay()
        {
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

                        //Add SurveyWord after the check
                        SurveyWord newSurveyWord = new SurveyWord()
                        {
                            date_used = DateTime.Now,
                            site_id = site.site_id,
                            survey_word_id = surveyWordToAdd.survey_word_id
                        };
                        context.SurveyWords.Add(newSurveyWord);
                        context.SaveChanges();
                        newSurveyWord = null;
                    }//End of loop in Site denoting that the site has a new potential survey word.                               
                }//End of check statement to see if theres enough active potential survey word to choose from the list.
            }//End of Transaction
        }

        public bool ValidateAccessWord(string enteredWord)
        {
            using (var context = new FSOSSContext())
            {
                return context.SurveyWords.Any(x => x.PotentialSurveyWord.survey_access_word.Equals(enteredWord) && x.date_used.Day == DateTime.Now.Day);
            }
        }

        public string GetSurveyWord(int siteID)
        {
            using (var context = new FSOSSContext())
            {
               string currentSurveyWord = (from x in context.SurveyWords
                                                  where x.site_id == siteID && x.date_used.Day == DateTime.Now.Day
                                                  select x.PotentialSurveyWord.survey_access_word).FirstOrDefault();
                return currentSurveyWord;
            }         
        }

        public void NewSite_NewWord(string siteName)
        {
            using (var context = new FSOSSContext())
            {
                //grab the new site id,
                int siteId = (from x in context.Sites
                              where x.site_name.Equals(siteName)
                              select x.site_id).FirstOrDefault();

                //get all the active words
                List<PotentialSurveyWord> potentialSurveyWordList = (from x in context.PotentialSurveyWords
                                                                     where x.archived_yn == false
                                                                     select x).ToList();
                //get all the surveywords
                List<SurveyWord> surveyWordList = (from x in context.SurveyWords
                                                   select x).ToList();
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
    }
}

