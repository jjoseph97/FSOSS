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
    public class AgeRangeController
    {
        /// <summary>
        /// Method use to get one age range object
        /// </summary>
        /// <param name="ageID"></param>
        /// <returns>One age range object</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public AgeRange GetTopicAge(int ageID)
        {

            using (var context = new FSOSSContext())
            {
                try
                {
                    AgeRange ageRange = new AgeRange();
                    ageRange = (from x in context.AgeRanges
                                where x.age_range_id == ageID
                                select x).FirstOrDefault();

                    return ageRange;
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }

            }
        }

        /// <summary>
        /// Method use to get list of age ranges
        /// </summary>
        /// <returns>List of age ranges</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<AgeRangePOCO> GetAgeRangeList()
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var ageRangeList = from x in context.AgeRanges
                                   select new AgeRangePOCO()
                                   {
                                       ageRangeID = x.age_range_id,
                                       ageRangeDescription = x.age_range_description
                                   };

                    return ageRangeList.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }
    }
}
