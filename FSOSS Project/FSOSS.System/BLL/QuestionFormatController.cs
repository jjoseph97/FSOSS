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
    [DataObject]
    public class QuestionFormatController
    {
        /// <summary>
        /// Method use to get one question format object
        /// </summary>
        /// <param name="formatID"></param>
        /// <returns>One question format object</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public QuestionFormat GetFormat(int formatID)
        {

            using (var context = new FSOSSContext())
            {
                try
                {
                    QuestionFormat questionFormat = new QuestionFormat();
                    questionFormat = (from x in context.QuestionFormats
                              where x.question_format_id == formatID
                              select x).FirstOrDefault();

                    return questionFormat;
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }

            }
        }
    }
}
