using System;
using System.Collections.Generic;
using System.Configuration;
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
    public class UnitsController
    {
        //[DataObjectMethod(DataObjectMethodType.Select, false)]
        //public List<UnitsPOCO> GetUnitList()
        //{
        //    using (var context = new FSOSSContext())
        //    {
        //        try
        //        {
        //            var unitList = from x in context.Sites
        //                           from y in context.Units
        //                           where x.site_id == y.site_id
        //                           & !y.is_closed_yn
        //                           select new UnitsPOCO()
        //                           {
        //                               unit_id = y.unit_id,
        //                               unit_number = y.unit_number
        //                           };

        //            return unitList.ToList();
        //        }
        //        catch (Exception e)
        //        {
        //            throw new Exception(e.Message);
        //        }
        //    }
        //}
    }
}

