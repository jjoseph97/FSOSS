using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region
using System.ComponentModel;
using FSOSS.System.Data.Entity;
using FSOSS.System.DAL;
#endregion

namespace FSOSS.System.BLL
{
    public class QuestionTopicController
    {
        /// <summary>
        /// Method use to get one question topic object
        /// </summary>
        /// <param name="topicID"></param>
        /// <returns>One question topic object</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public QuestionTopic GetTopic(int topicID)
        {

            using (var context = new FSOSSContext())
            {
                try
                {
                    QuestionTopic questionTopic = new QuestionTopic();
                    questionTopic = (from x in context.QuestionTopics
                                      where x.question_topic_id == topicID
                                      select x).FirstOrDefault();

                    return questionTopic;
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }

            }
        }
    }
}
