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
using Stiig;

public partial class user_showpost : System.Web.UI.Page
{
    int postID = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        DataAccessLayer dal = new DataAccessLayer();
        DataTable dt = new DataTable();

        if (!int.TryParse(Request.QueryString["ID"], out postID))
            Response.Redirect("~/error.aspx?errorcode=nopost", true);

        updateRptComments();
    }
    public void updateRptComments()
    {
        DataAccessLayer dal = new DataAccessLayer();

        dal.AddParameter("@PostID", postID, DbType.Int32);
        rptComments.DataSource = dal.ExecuteDataTable("SELECT * FROM [Comments] WHERE [PostRefID] = @PostID AND [Deleted] = 0");
        rptComments.DataBind();
        dal.ClearParameters();
    }
    protected void btnComment_Click(object sender, EventArgs e)
    {
        DataAccessLayer dal = new DataAccessLayer();

        dal.AddParameter("@CommentPostID", postID, DbType.Int32);
        dal.AddParameter("@CommentUserID", Membership.GetUser().ProviderUserKey, DbType.Guid);
        dal.AddParameter("@CommentDateTimeAdded", DateTime.Now, DbType.DateTime);
        dal.AddParameter("@CommentText", ((TextBox)lgnvwComment.FindControl("txtbxComment")).Text, DbType.String);
        dal.ExecuteNonQuery("INSERT INTO [Comments] ([CommentPostID], [CommentUserID], [CommentDateTimeAdded], [CommentText]) VALUES(@CommentPostID, @CommentUserID, @CommentDateTimeAdded, @CommentText)");
        dal.ClearParameters();

        ((TextBox)lgnvwComment.FindControl("txtbxComment")).Text = "";

        updateRptComments();
    }
    protected void rptComments_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            if (User.Identity.IsAuthenticated)
            {
                bool showDelete = DataBinder.Eval(e.Item.DataItem, "CommentUserID").ToString() == Membership.GetUser().ProviderUserKey.ToString();

                if (User.IsInRole("Admin"))
                {
                    showDelete = true;
                }

                Control c2 = e.Item.FindControl("DeleteLink");
                c2.Visible = showDelete;
            }
        }
    }
    protected void rptComments_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        DataAccessLayer dal = new DataAccessLayer();

        string CommentID = e.CommandArgument.ToString();

        dal.AddParameter("@CommentID", CommentID, DbType.Int32);
        dal.ExecuteNonQuery("UPDATE [Comments] SET [CommentDeleted] = 1 WHERE [CommentID] = @CommentID");
        dal.ClearParameters();

        updateRptComments();
    }
}