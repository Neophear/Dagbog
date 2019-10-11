using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class admin_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //foreach (MembershipUser user in Membership.GetAllUsers())
        //{
        //    ProfileCommon profile = Profile.GetProfile(user.UserName);
        //    profile.Personal.Birthday = new DateTime(1987, 4, 12);
        //    profile.Save();
        //}

        //ProfileCommon userprofile = Profile.GetProfile("Street");
        //userprofile.Options.ShowBirthAge = 0;
        //userprofile.Save();
    }
}
