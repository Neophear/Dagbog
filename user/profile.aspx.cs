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

public partial class user_profile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ProfileCommon profile = Profile.GetProfile(User.Identity.Name);

            rblGroup.Items.FindByValue(profile.Options.DefaultPrivacySetting).Selected = true;
            rblFriendRequest.Items.FindByValue(profile.Options.AllowFriendRequests.ToString()).Selected = true;
            rblShowBirthAge.Items.FindByValue(profile.Options.ShowBirthAge.ToString()).Selected = true;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        ProfileCommon profile = Profile.GetProfile(User.Identity.Name);

        profile.Options.AllowFriendRequests = Convert.ToBoolean(rblFriendRequest.SelectedValue);
        profile.Options.DefaultPrivacySetting = rblGroup.SelectedValue;
        profile.Options.ShowBirthAge = Convert.ToInt32(rblShowBirthAge.SelectedValue);
        profile.Save();
        lblSettingsSaved.Visible = true;
    }
}