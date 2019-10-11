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

public partial class user_editpost : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataAccessLayer dal = new DataAccessLayer();
            DataTable dt = new DataTable();
            string postID = "";

            try
            {
                postID = Request.QueryString["ID"].ToString();
            }
            catch
            {
                Response.Redirect("~/error.aspx?errorcode=nopost");
                throw;
            }

            try
            {
                Convert.ToInt32(postID);
            }
            catch
            {
                Response.Redirect("~/error.aspx?errorcode=wrongidsyntax");
                throw;
            }

            dal.AddParameter("@PostID", postID, DbType.Int32);
            dt = dal.ExecuteDataTable("SELECT * FROM [Posts] WHERE [PostID] = @PostID AND [PostDeleted] = 0");
            dal.ClearParameters();

            if (dt.Rows.Count == 0)
            {
                Response.Redirect("~/error.aspx?errorcode=nopost");
            }
            
            if (Utilities.AccessLevelToPost(Membership.GetUser().ProviderUserKey, postID) == 2)
            {
                txtbxTitle.Text = dt.Rows[0]["PostTitle"].ToString();
                txtbxPost.Text = dt.Rows[0]["PostText"].ToString();
                rblGroup.Items.FindByValue(dt.Rows[0]["PostGroup"].ToString()).Selected = true;
                hdnfldPostID.Value = postID;
            }
            else
            {
                Response.Redirect("~/error.aspx?errorcode=noaccesstopost");
            }
        }
    }
    protected void btnSubmitPost_Click(object sender, EventArgs e)
    {
        DataAccessLayer dal = new DataAccessLayer();
        string postID = hdnfldPostID.Value;

        dal.AddParameter("@PostID", postID, DbType.Int32);
        dal.AddParameter("@PostGroup", rblGroup.SelectedValue, DbType.Boolean);
        dal.AddParameter("@PostTitle", txtbxTitle.Text, DbType.String);
        dal.AddParameter("@PostText", txtbxPost.Text, DbType.String);
        dal.ExecuteNonQuery("UPDATE [Posts] SET PostGroup = @PostGroup, PostTitle = @PostTitle, PostText = @PostText WHERE PostID = @PostID");
        dal.ClearParameters();

        Response.Redirect("~/showpost.aspx?ID=" + postID);
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/showpost.aspx?ID=" + hdnfldPostID.Value);
    }
}