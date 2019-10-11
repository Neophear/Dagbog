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

public partial class public_createuser : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
    {
        ProfileCommon profile = Profile.GetProfile(CreateUserWizard1.UserName);
        profile.Options.AllowFriendRequests = true;
        profile.Options.DefaultPrivacySetting = "pr";
        profile.Options.DefaultFont = "Comic Sans MS";
        profile.Options.ShowBirthAge = 1;
        profile.Personal.Birthday = Convert.ToDateTime(((TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("BirthdayTextBox")).Text);
        profile.Personal.IsMale = Convert.ToBoolean(((RadioButtonList)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("IsMaleRBL")).SelectedValue);
        profile.Save();
        Roles.AddUserToRole(CreateUserWizard1.UserName, "User");

        //Her skal man så sende en bekræftelsesemail.
    }
}
