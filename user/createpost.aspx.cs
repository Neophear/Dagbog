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

public partial class user_createpost : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void dvCreatePost_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        e.Values["CreatedBy"] = Membership.GetUser().ProviderUserKey;
        e.Values["CategoryRefID"] = ((DropDownList)dvCreatePost.FindControl("ddlCategory")).SelectedValue;
    }
    protected void sdsCreatePost_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        Response.Redirect("~/showpost.aspx?ID=" + e.Command.Parameters["@LastID"].Value);
    }
}