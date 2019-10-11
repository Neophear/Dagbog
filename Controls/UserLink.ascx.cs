using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_UserLink : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private MembershipUser user;
    private Guid userid;

    public Guid UserID
    {
        get
        {
            return userid;
        }

        set
        {
            userid = value;

            user = Membership.GetUser(userid);

            hplUserLink.Text = user.UserName;
            hplUserLink.NavigateUrl = String.Format("~/showuser.aspx?ID={0}", user.ProviderUserKey.ToString());
        }
    }
}