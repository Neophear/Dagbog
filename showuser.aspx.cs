using System;
using System.Collections;
using System.Collections.Generic;
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
using Stiig;

public partial class showuser : System.Web.UI.Page
{
    public DataAccessLayer dal = new DataAccessLayer();

    protected void Page_Load(object sender, EventArgs e)
    {
        MembershipUser userToView;

        try
        {
            userToView = Membership.GetUser(Request.QueryString["name"]);
        }
        catch
        {
            Response.Redirect("~/error.aspx?errorcode=nouser");
            throw;
        }

        if (userToView == null)
        {
            Response.Redirect("~/error.aspx?errorcode=nouser", true);
        }

        hdnUserID.Value = userToView.ProviderUserKey.ToString();
        hdnUserName.Value = userToView.UserName;

        //Her viser jeg fødselsdag/alder:
        ProfileCommon userProfile = Profile.GetProfile(userToView.UserName);
        
        switch (userProfile.Options.ShowBirthAge)
        {
            case 0:
                mvShowBirthAge.ActiveViewIndex = 0;
                lblBirthday.Text = userProfile.Personal.Birthday.ToLongDateString();
                lblAge.Text = Utilities.GetAge(userProfile.Personal.Birthday).ToString();
                break;
            case 1:
                mvShowBirthAge.ActiveViewIndex = 1;
                lblAge2.Text = Utilities.GetAge(userProfile.Personal.Birthday).ToString();
                break;
            default:
                mvShowBirthAge.Visible = false;
                break;
        }
        //-------------------------

        lblUsername.Text = userToView.UserName;

        dal.AddParameter("@PostUserID", userToView.ProviderUserKey, DbType.Guid);
        lblPublicPosts.Text = dal.ExecuteScalar("SELECT COUNT(*) FROM [Posts] WHERE [PostUserID] = @PostUserID").ToString();
        dal.ClearParameters();

        string selectStatement = "";

        if (User.Identity.IsAuthenticated)
        {
            if (User.IsInRole("Admin") || Membership.GetUser().ProviderUserKey.ToString() == userToView.ProviderUserKey.ToString())
            {
                selectStatement = "SELECT * FROM [Posts] WHERE [PostUserID] = @PostUserID";
            }
            else if (Utilities.CheckIfFriends(Membership.GetUser().ProviderUserKey, userToView.ProviderUserKey) == 2)
            {
                selectStatement = "SELECT * FROM [Posts] WHERE [PostUserID] = @PostUserID AND ([PostGroup] = 'pu' OR [PostGroup] = 'fr')";
            }
            else
            {
                selectStatement = "SELECT * FROM [Posts] WHERE [PostUserID] = @PostUserID AND [PostGroup] = 'pu'";
            }
        }
        else
        {
            selectStatement = "SELECT * FROM [Posts] WHERE [PostUserID] = @PostUserID AND [PostGroup] = 'pu'";
        }

        DataTable userCal = new DataTable();

        dal.AddParameter("@PostUserID", userToView.ProviderUserKey, DbType.Guid);
        userCal = dal.ExecuteDataTable(selectStatement);
        dal.ClearParameters();

        lstvwPosts.DataSource = userCal;
        lstvwPosts.DataBind();

        dtcalPosts.DataSource = userCal;
        dtcalPosts.DataBind();

        if (userToView.IsOnline)
	    {
            lblLastOnline.Text = "Online nu!";
	    }
        else
        {
            lblLastOnline.Text = Utilities.GetDate(userToView.LastActivityDate);
        }

        if (User.Identity.IsAuthenticated)
        {
            if (User.Identity.Name == userToView.UserName)
            {
                pnlFriend.Visible = false;
            }
            else
            {
                switch (Utilities.CheckIfFriends(Membership.GetUser().ProviderUserKey, userToView.ProviderUserKey))
                {
                    case 0:
                        lblIsFriend.Text = "Er ikke din ven";

                        if (userProfile.Options.AllowFriendRequests)
                        {
                            lnkbtnAddFriend.Visible = true;
                            lnkbtnRemoveFriend.Visible = false;
                        }
                        else
                        {
                            lnkbtnAddFriend.Visible = false;
                            lnkbtnRemoveFriend.Visible = false;
                        }

                        lnkbtnAcceptFriend.Visible = false;
                        break;
                    case 1:
                        lblIsFriend.Text = "Afventer bekræftelse...";
                        lnkbtnRemoveFriend.Visible = false;
                        lnkbtnAddFriend.Visible = false;
                        lnkbtnAcceptFriend.Visible = false;
                        break;
                    case 2:
                        lblIsFriend.Text = "Bekræft venskab";
                        lnkbtnRemoveFriend.Visible = true;
                        lnkbtnAddFriend.Visible = false;
                        lnkbtnAcceptFriend.Visible = true;
                        break;
                    case 3:
                        lblIsFriend.Text = "Er din ven";
                        lnkbtnRemoveFriend.Visible = true;
                        lnkbtnAddFriend.Visible = false;
                        lnkbtnAcceptFriend.Visible = false;
                        break;
                    default:
                        break;
                }
            }
        }
        else
        {
            pnlFriend.Visible = false;
        }
    }
    protected void lnkbtnRemoveFriend_Click(object sender, EventArgs e)
    {
        dal.AddParameter("@UserA", Membership.GetUser().ProviderUserKey.ToString(), DbType.Guid);
        dal.AddParameter("@UserB", hdnUserID.Value, DbType.Guid);
        dal.ExecuteNonQuery("DELETE FROM [Friends] WHERE ([FriendsUserA] = @UserA AND [FriendsUserB] = @UserB) OR ([FriendsUserA] = @UserB AND [FriendsUserB] = @UserA)");
        dal.ClearParameters();

        lblIsFriend.Text = "Er ikke din ven";

        ProfileCommon userProfile = Profile.GetProfile(hdnUserName.Value);

        if (userProfile.Options.AllowFriendRequests)
        {
            lnkbtnAddFriend.Visible = true;
            lnkbtnRemoveFriend.Visible = false;
        }
        else
        {
            lnkbtnAddFriend.Visible = false;
            lnkbtnRemoveFriend.Visible = false;
        }

        lnkbtnAcceptFriend.Visible = false;
    }
    protected void lnkbtnAddFriend_Click(object sender, EventArgs e)
    {
        dal.AddParameter("@UserA", Membership.GetUser().ProviderUserKey.ToString(), DbType.Guid);
        dal.AddParameter("@UserB", hdnUserID.Value, DbType.Guid);
        dal.AddParameter("@DateTimeCreated", DateTime.Now, DbType.DateTime);
        dal.ExecuteNonQuery("INSERT INTO [Friends] ([FriendsUserA], [FriendsUserB], [FriendsDateTimeRequested]) VALUES(@UserA, @UserB, @DateTimeCreated)");
        dal.ClearParameters();

        lnkbtnRemoveFriend.Visible = false;
        lnkbtnAddFriend.Visible = false;
        lnkbtnAcceptFriend.Visible = false;
        lblIsFriend.Text = "Afventer bekræftelse...";
    }
    protected void lnkbtnAcceptFriend_Click(object sender, EventArgs e)
    {
        dal.AddParameter("@UserA", Membership.GetUser().ProviderUserKey.ToString(), DbType.Guid);
        dal.AddParameter("@UserB", hdnUserID.Value, DbType.Guid);
        dal.AddParameter("@DateTimeAccepted", DateTime.Now, DbType.DateTime);
        dal.ExecuteNonQuery("UPDATE [Friends] SET [FriendsAccepted] = 1, [FriendsDateTimeAccepted] = @DateTimeAccepted WHERE ([FriendsUserA] = @UserA AND [FriendsUserB] = @UserB) OR ([FriendsUserA] = @UserB AND [FriendsUserB] = @UserA)");
        dal.ClearParameters();

        lnkbtnRemoveFriend.Visible = true;
        lnkbtnAddFriend.Visible = false;
        lnkbtnAcceptFriend.Visible = false;
        lblIsFriend.Text = "Er din ven";
    }
}