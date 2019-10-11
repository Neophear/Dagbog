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

public partial class error : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string errorCode = "";
        string errorText = "";

        if (Request.QueryString["errorcode"] != null)
        {
            errorCode = Request.QueryString["errorcode"].ToLower();
        }

        switch (errorCode)
        {
            case "403":
                errorText = "Du har ikke adgang til denne fil/side.";
                break;
            case "404":
                errorText = "Filen/siden eksisterer ikke";
                break;
            case "noaccesstopost":
                errorText = "Du har ikke adgang til denne post";
                break;
            case "nopost":
                errorText = "Kunne ikke finde den pågældende post.";
                break;
            case "nouser":
                errorText = "Der er ingen bruger oprettet med det navn.";
                break;
            case "wrongidsyntax":
                errorText = "Der blev ikke givet et gyldigt ID";
                break;
            default:
                errorText = "Der er sket en udefineret fejl.";
                break;
        }

        lblErrorMsg.Text = errorText;
    }
}
