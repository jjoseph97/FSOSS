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
    public class GenderController
    {
        /// <summary>
        /// Method use to get one gender object
        /// </summary>
        /// <param name="genderID"></param>
        /// <returns>One gender object</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public Gender GetGender(int genderID)
        {

            using (var context = new FSOSSContext())
            {
                try
                {
                    Gender gender = new Gender();
                    gender = (from x in context.Genders
                                where x.gender_id == genderID
                                select x).FirstOrDefault();

                    return gender;
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }

            }
        }

        /// <summary>
        /// Method use to get list of genders
        /// </summary>
        /// <returns>List of genders</returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<GenderPOCO> GetGenderList()
        {
            using (var context = new FSOSSContext())
            {
                try
                {
                    var genderList = from x in context.Genders
                                       select new GenderPOCO()
                                       {
                                           genderID = x.gender_id,
                                           genderDescription = x.gender_description
                                       };

                    return genderList.ToList();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }
    }
}
