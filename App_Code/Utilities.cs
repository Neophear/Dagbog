using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.Configuration;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;

namespace Stiig
{
    public class Utilities
    {
        /// <summary>
        /// Gets the age out from a DateTime.
        /// </summary>
        /// <param name="birthday">The DateTime birthday</param>
        /// <returns>Returns an Int representing the age like "24"</returns>
        public static int GetAge(DateTime birthday)
        {
            int age = 0;

            if (birthday.Month == DateTime.Today.Month)
            {
                if (birthday.Day <= DateTime.Today.Day)
                {
                    age = DateTime.Today.Year - birthday.Year;
                }
                else
                {
                    age = DateTime.Today.Year - birthday.Year - 1;
                }
            }
            else if (birthday.Month < DateTime.Today.Month)
            {
                age = DateTime.Today.Year - birthday.Year;
            }
            else
            {
                age = DateTime.Today.Year - birthday.Year - 1;
            }

            return age;
        }
        /// <summary>
        /// Check to see if UsernameA and UsernameB are friends. UsernameA should be the user loggedin and viewing and UsernameB should be the user viewed.
        /// Returns the following:
        /// 0: Not friends
        /// 1: UserA has requested UserB friendsship and is pending.
        /// 2: UserA has been requested by UserB and needs to accept or reject.
        /// 3: Are friends.
        /// </summary>
        /// <param name="UsernameA">Username of the user currently logged in and viewing</param>
        /// <param name="UsernameB">Username of the user being viewed</param>
        /// <returns></returns>
        public static int CheckIfFriends(object UserIDA, object UserIDB)
        {
            int areFriends = 0;

            DataAccessLayer dal = new DataAccessLayer();

            dal.AddParameter("@UserA", UserIDA, DbType.Guid);
            dal.AddParameter("@UserB", UserIDB, DbType.Guid);
            string areFriendsString = dal.ExecuteScalar("SELECT ").ToString();
            dal.ClearParameters();

            areFriends = Convert.ToInt32(areFriendsString);

            return areFriends;
        }
        /// <summary>
        /// Checks to see the authenticated users accesslevel to the postID.
        /// 0: No access
        /// 1: Viewable
        /// 2: Editable
        /// </summary>
        /// <param name="Username">The name of the user currently logged in (Page.User.Identity.Name)</param>
        /// <param name="postID">The ID of the post to check</param>
        /// <returns>Accesslevel as Int</returns>
        public static int AccessLevelToPost(object UserID, string postID)
        {
            int accessLevel = 0;

            DataAccessLayer dal = new DataAccessLayer();

            dal.AddParameter("@PostID", postID, DbType.Int32);
            DataTable dt = dal.ExecuteDataTable("SELECT [PostUserID], [PostGroup] FROM [Posts] WHERE [PostID] = @PostID");
            dal.ClearParameters();

            if (UserID.ToString() == Guid.Empty.ToString())
            {
                if (dt.Rows[0]["PostGroup"].ToString() == "pu")
                {
                    accessLevel = 1;
                }
            }
            else
            {
                if (Roles.IsUserInRole(Membership.GetUser(UserID).UserName, "Admin"))
                {
                    accessLevel = 2;
                }
                else if (dt.Rows[0]["PostUserID"].ToString() == UserID.ToString())
                {
                    accessLevel = 2;
                }
                else if (CheckIfFriends(UserID, dt.Rows[0]["PostUserID"]) == 3 && dt.Rows[0]["PostGroup"].ToString() == "fr")
                {
                    accessLevel = 1;
                }
                else if (dt.Rows[0]["PostGroup"].ToString() == "pu")
                {
                    accessLevel = 1;
                }
            }

            return accessLevel;
        }
        public static List<MembershipUser> GetOnlineUsers()
        {
            List<MembershipUser> onlineUsers = new List<MembershipUser>();

            foreach (MembershipUser user in Membership.GetAllUsers())
            {
                if (user.IsOnline)
                {
                    onlineUsers.Add(user);
                }
            }

            return onlineUsers;
        }
        /// <summary>
        /// Cuts a string to a specified length.
        /// </summary>
        /// <param name="text">String to cut</param>
        /// <param name="addString">String to add after the cut has been made. Fx. "..."</param>
        /// <param name="maxLength">Max length the resulting string shall be without the addString</param>
        /// <returns></returns>
        public static string CutText(string text, string addString, int maxLength)
        {
            return CutText(text, addString, maxLength, false);
        }
        /// <summary>
        /// Cuts a string to a specified length depending on if it should cut at whole words or not.
        /// </summary>
        /// <param name="text">String to cut</param>
        /// <param name="addString">String to add after the cut has been made. Fx. "..."</param>
        /// <param name="maxLength">Max length the resulting string shall be without the addString</param>
        /// <param name="wholeWords">True to leave whole words and false to ignore whole words and just cut</param>
        /// <returns></returns>
        public static string CutText(string text, string addString, int maxLength, bool wholeWords)
        {
            string endString = "";

            if (text.Length <= maxLength)
            {
                endString = text;
            }
            else
            {
                if (!wholeWords)
                {
                    endString = text.Substring(0, maxLength);
                    endString = endString.TrimEnd(new char[] { ' ' });
                }
                else
                {
                    endString = text.Substring(0, maxLength + 1);
                    int lastIndexOfSpace = endString.LastIndexOf(" ");

                    endString = endString.Substring(0, lastIndexOfSpace);
                }

                endString += addString;
            }

            return endString;
        }
        /// <summary>
        /// Returns a more userfriendly date.
        /// </summary>
        /// <param name="date">The DateTime to modify</param>
        /// <returns></returns>
        public static string GetDate(DateTime date)
        {
            string modifieddate = "{0} {1} siden";
            TimeSpan diff = DateTime.Now - date;

            int years = DateTime.Now.Year - date.Year;
            int months = diff.Days / 30;
            int weeks = diff.Days / 7;

            if (years > 0)
            {
                modifieddate = string.Format(modifieddate, years, "år");
            }
            else if (months > 0)
            {
                modifieddate = string.Format(modifieddate, months, months > 1 ? "måneder" : "måned");
            }
            else if (weeks > 0)
            {
                modifieddate = string.Format(modifieddate, weeks, weeks > 1 ? "uger" : "uge");
            }
            else if (diff.Days > 1)
            {
                modifieddate = string.Format(modifieddate, diff.Days, "dage");
            }
            else if (diff.Days == 1)
            {
                modifieddate = "I går";
            }
            else if (diff.Hours > 0)
            {
                modifieddate = string.Format(modifieddate, diff.Hours, diff.Hours > 1 ? "timer" : "time");
            }
            else if (diff.Minutes > 0)
            {
                modifieddate = string.Format(modifieddate, diff.Minutes, diff.Minutes > 1 ? "minutter" : "minut");
            }
            else if (diff.Seconds > 1)
            {
                modifieddate = string.Format(modifieddate, diff.Seconds, "sekunder");
            }
            else
            {
                modifieddate = "Nu";
            }

            return modifieddate;
        }
        public static int GetPageOfPost(int ThreadID, int PostID, int PostsPerPage)
        {
            int LastPage;

            DataAccessLayer dal = new DataAccessLayer();

            dal.AddParameter("@ThreadID", ThreadID, DbType.Int32);
            dal.AddParameter("@PostID", PostID, DbType.Int32);
            int PostCount = Convert.ToInt32(dal.ExecuteScalar("SELECT COUNT(*) FROM Posts WHERE ThreadRefID = @ThreadID AND ID <= @PostID"));
            dal.ClearParameters();

            if ((PostCount % PostsPerPage) == 0)
            {
                LastPage = PostCount / PostsPerPage;
            }
            else
            {
                LastPage = PostCount / PostsPerPage + 1;
            }

            return LastPage;
        }
        public static string HTMLToBB(string OriginalText)
        {
            string text = OriginalText;

            List<Regex> regexlist = new List<Regex>();

            regexlist.Add(new Regex(@"<(?<tag>b)>(?<text>[\w\W]*?)</b>"));
            regexlist.Add(new Regex(@"<(?<tag>i)>(?<text>[\w\W]*?)</i>"));
            regexlist.Add(new Regex(@"<(?<tag>u)>(?<text>[\w\W]*?)</u>"));

            Regex quotewithauthor = new Regex("<table\\ cellpadding=\"2\"><tr><td\\ class=\"quote\">Citat\\ af\\ (?<author>.*?)<br\\ /><i>(?<text>[\\w\\W]*?)</i></td></tr></table>");
            Regex quote = new Regex("<table\\ cellpadding=\"2\"><tr><td\\ class=\"quote\"><i>(?<text>[\\w\\W]*?)</i></td></tr></table>");
            Regex urlwithtitle = new Regex("<a href=\"(?<link>[\\w\\W]*?)\">(?<text>[\\w\\W]*?)</a>");
            Regex url = new Regex("<a\\ href=\"(?<link>[\\w\\W]*?)\">\\1</a>");
            Regex size = new Regex("<span\\ style=\"font-size:(?<size>\\d*?)pt;\">(?<text>[\\w\\W]*?)</span>");
            Regex color = new Regex("<span\\ style=\"color:(?<color>.*?);\">(?<text>[\\w\\W]*?)</span>");

            text = quotewithauthor.Replace(text, @"[quote=$1]$2[/quote]");
            text = quote.Replace(text, @"[quote]$1[/quote]");
            text = url.Replace(text, @"[url]$1[/url]");
            text = urlwithtitle.Replace(text, @"[url=$1]$2[/url]");
            text = size.Replace(text, @"[size=$1]$2[/size]");
            text = color.Replace(text, @"[color=$1]$2[/color]");

            foreach (Regex regex in regexlist)
            {
                text = regex.Replace(text, @"[$1]$2[/$1]");
            }

            text = text.Replace("<table cellpadding=\"2\"><tr><td class=\"quote\"><i>", "[quote]").Replace("</i></td></tr></table>", "[/quote]");
            text = text.Replace("<img src=\"", "[img]").Replace("\"/>", "[/img]");
            text = text.Replace("<table cellpadding=\"2\"><tr><td class=\"code\">", "[code]").Replace("</td></tr></table>", "[/code]");
            text = text.Replace("<br />", "");
            text = text.Replace("&#60;", "<");
            text = text.Replace("&#62;", ">");

            return text;
        }
        public static string BBToHTML(string OriginalText)
        {
            string text;
            List<Regex> regexlist = new List<Regex>();
            text = OriginalText;

            regexlist.Add(new Regex(@"\[(?<tag>b)\](?<text>[\w\W]*?)\[/b\]"));
            regexlist.Add(new Regex(@"\[(?<tag>i)\](?<text>[\w\W]*?)\[/i\]"));
            regexlist.Add(new Regex(@"\[(?<tag>u)\](?<text>[\w\W]*?)\[/u\]"));

            Regex quote = new Regex(@"\[quote\](?<text>[\w\W]*?)\[/quote\]");
            Regex quotewithauthor = new Regex(@"\[quote=(?<author>.*?)\](?<text>[\w\W]*?)\[/quote\]");
            Regex code = new Regex(@"\[code\](?<text>[\w\W]*?)\[/code\]");
            Regex url = new Regex(@"\[url\](?<link>[\w\W]*?)\[/url\]");
            Regex urlwithtitle = new Regex(@"\[url=(?<title>.*?)\](?<link>[\w\W]*?)\[/url\]");
            Regex image = new Regex(@"\[img\](?<link>[\w\W]*?)\[/img\]");
            Regex size = new Regex(@"\[size=(?<size>\d*?)\](?<text>[\w\W]*?)\[/size\]");
            Regex color = new Regex(@"\[color=(?<color>[\w\W]*?)\](?<text>[\w\W]*?)\[/color\]");

            text = text.Replace("<", "&#60;");
            text = text.Replace(">", "&#62;");

            text = Utilities.ToggleHtmlBR(text, true);

            foreach (Regex regex in regexlist)
            {
                text = regex.Replace(text, "<$1>$2</$1>");
            }

            text = quote.Replace(text, "<table cellpadding=\"2\"><tr><td class=\"quote\"><i>$1</i></td></tr></table>");
            text = code.Replace(text, "<table cellpadding=\"2\"><tr><td class=\"code\">$1</td></tr></table>");
            text = quotewithauthor.Replace(text, "<table cellpadding=\"2\"><tr><td class=\"quote\">Citat af $1<br /><i>$2</i></td></tr></table>");
            text = url.Replace(text, "<a href=\"$1\">$1</a>");
            text = urlwithtitle.Replace(text, "<a href=\"$1\">$2</a>");
            text = image.Replace(text, "<img src=\"$1\"/>");
            text = size.Replace(text, "<span style=\"font-size:$1pt;\">$2</span>");
            text = color.Replace(text, "<span style=\"color:$1;\">$2</span>");

            return text;
        }
        public static string GetSmileys(string text, string smileydir)
        {
            DataAccessLayer dal = new DataAccessLayer();

            DataTable table = dal.ExecuteDataTable("SELECT smileyName, smileyCode, smileyFileName FROM Smileys");

            for (int i = 0; i < table.Rows.Count; i++)
            {
                text = text.Replace(table.Rows[i][1].ToString(), "<img alt=\"" + table.Rows[i][0].ToString() + "\" src=\"" + smileydir + table.Rows[i][2].ToString() + "\">");
            }

            return text;
        }
        public static string RemoveEndString(string Text, string TextToRemove)
        {
            string result = Text;

            if (Text.EndsWith(TextToRemove))
            {
                result = Text.Remove(Text.Length - TextToRemove.Length);
            }

            return result;
        }
        public static void CreateThumbnail(string OriginalImagePath, string NewImagePath, float Width, float Height)
        {
            float width = Width;
            float height = Height;
            Bitmap original = new Bitmap(OriginalImagePath);
            float imageRatio = (float)original.Width / (float)original.Height;

            if (imageRatio > 1)
            {
                width = Height / original.Height * original.Width;

                if (width > Width)
                {
                    height = Width / original.Width * original.Height;
                    width = Width;
                }
            }
            else
            {
                height = Width / original.Width * original.Height;

                if (height > Height)
                {
                    width = Height / original.Height * original.Width;
                    height = Height;
                }
            }

            Bitmap image = new Bitmap(original, (int)width, (int)height);
            image.Save(NewImagePath);
            original.Dispose();
            image.Dispose();
        }
        public static string GetSiteRoot()
        {
            string Port = System.Web.HttpContext.Current.Request.ServerVariables["SERVER_PORT"];

            if (Port == null || Port == "80" || Port == "443")
            {
                Port = "";
            }
            else
            {
                Port = ":" + Port;
            }

            string Protocol = System.Web.HttpContext.Current.Request.ServerVariables["SERVER_PORT_SECURE"];

            if (Protocol == null || Protocol == "0")
            {
                Protocol = "http://";
            }
            else
            {
                Protocol = "https://";
            }

            string appPath = System.Web.HttpContext.Current.Request.ApplicationPath;

            if (appPath == "/")
            {
                appPath = "";
            }

            string sOut = Protocol + System.Web.HttpContext.Current.Request.ServerVariables["SERVER_NAME"] + Port + appPath;
            return sOut;
        }
        public static string GetFileText(string virtualPath)
        {
            StreamReader sr = null;

            try
            {
                sr = new StreamReader(System.Web.HttpContext.Current.Server.MapPath(virtualPath));
            }
            catch
            {
                sr = new StreamReader(virtualPath);
            }

            string strOut = sr.ReadToEnd();
            sr.Close();
            return strOut;
        }
        public static void UpdateFileText(string AbsoluteFilePath, string LookFor, string ReplaceWith)
        {
            string sIn = GetFileText(AbsoluteFilePath);
            string sOut = sIn.Replace(LookFor, ReplaceWith);
            WriteToFile(AbsoluteFilePath, sOut);
        }
        public static void WriteToFile(string AbsoluteFilePath, string fileText)
        {
            StreamWriter sw = new StreamWriter(AbsoluteFilePath, false);
            sw.Write(fileText);
            sw.Close();
        }
        public static string StripHTML(string htmlString)
        {
            return StripHTML(htmlString, "", true);
        }
        public static string StripHTML(string htmlString, string htmlPlaceHolder)
        {
            return StripHTML(htmlString, htmlPlaceHolder, true);
        }
        public static string StripHTML(string htmlString, string htmlPlaceHolder, bool stripExcessSpaces)
        {
            string pattern = @"<(.|\n)*?>";
            string sOut = System.Text.RegularExpressions.Regex.Replace(htmlString, pattern, htmlPlaceHolder);
            sOut = sOut.Replace("&nbsp;", "");
            sOut = sOut.Replace("&amp;", "&");

            if (stripExcessSpaces)
            {
                // If there is excess whitespace, this will remove
                // like "THE      WORD".
                char[] delim = { ' ' };
                string[] lines = sOut.Split(delim, StringSplitOptions.RemoveEmptyEntries);

                sOut = "";
                System.Text.StringBuilder sb = new System.Text.StringBuilder();

                foreach (string s in lines)
                {
                    sb.Append(s);
                    sb.Append(" ");
                }

                return sb.ToString().Trim();
            }
            else
            {
                return sOut;
            }
        }
        public static string ToggleHtmlBR(string text, bool isOn)
        {
            string outS = "";

            if (isOn)
                outS = text.Replace("\n", "<br />");
            else
            {
                outS = text.Replace("<br />", "\n");
                outS = text.Replace("<br>", "\n");
                outS = text.Replace("<br >", "\n");
            }

            return outS;
        }
    }
}