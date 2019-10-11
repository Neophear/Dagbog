<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="showuser.aspx.cs" Inherits="showuser" Title="Untitled Page" %>
<%@ Register Namespace="DataControls" Assembly="DataCalendar" TagPrefix="dc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:HiddenField ID="hdnUserID" runat="server" />
    <asp:HiddenField ID="hdnUserName" runat="server" />
    <table>
        <tr>
            <td>
                Brugernavn:
            </td>
            <td>
                <asp:Label ID="lblUsername" runat="server" Text="lblUsername"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Antal offentlige indlæg:
            </td>
            <td>
                <asp:Label ID="lblPublicPosts" runat="server" Text="lblPublicPosts"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Sidst online:
            </td>
            <td>
                <asp:Label ID="lblLastOnline" runat="server" Text="lblLastOnline"></asp:Label>
            </td>
        </tr>
        <asp:Panel ID="pnlFriend" runat="server">
            <tr>
                <td>
                    Er din ven:
                </td>
                <td>
                    <asp:Label ID="lblIsFriend" runat="server" Text="lblIsFriend"></asp:Label>
                    <asp:LinkButton ID="lnkbtnAddFriend" runat="server" Text="Ansøg" 
                        onclick="lnkbtnAddFriend_Click"></asp:LinkButton>
                    <asp:LinkButton ID="lnkbtnRemoveFriend" runat="server" Text="Fjern" 
                        onclick="lnkbtnRemoveFriend_Click"></asp:LinkButton>
                    <asp:LinkButton ID="lnkbtnAcceptFriend" runat="server" Text="Accepter" 
                        onclick="lnkbtnAcceptFriend_Click"></asp:LinkButton>
                </td>
            </tr>
        </asp:Panel>
        <asp:MultiView ID="mvShowBirthAge" runat="server">
            <asp:View ID="vShowBirthAge" runat="server">
                <tr>
                    <td>
                        Fødselsdag:
                    </td>
                    <td>
                        <asp:Label ID="lblBirthday" runat="server" Text="lblBirthday"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        Alder:
                    </td>
                    <td>
                        <asp:Label ID="lblAge" runat="server" Text="lblAge"></asp:Label>
                    </td>
                </tr>
            </asp:View>
            <asp:View ID="vShowAge" runat="server">
                <tr>
                    <td>
                        Alder:
                    </td>
                    <td>
                        <asp:Label ID="lblAge2" runat="server" Text="lblAge2"></asp:Label>
                    </td>
                </tr>
            </asp:View>
        </asp:MultiView>
    </table>
    <dc:DataCalendar id="dtcalPosts" runat="server" width="100%" 
                             DayField="PostDateTimeCreated">
        <DayStyle HorizontalAlign="Left" VerticalAlign="Top"
                          Font-Size="8" Font-Name="Arial" />
                          
        <OtherMonthDayStyle BackColor="LightGray" ForeColor="DarkGray"
                   />

        <ItemTemplate>
            <br />                    
            <a href='showpost.aspx?id=<%# Container.DataItem["PostID"] %>'>
                <%# Container.DataItem["PostTitle"] %>
            </a>                            
        </ItemTemplate>
        
        <NoEventsTemplate>
            <br />
            <br />
            <br />
            <br />
            <br />
        </NoEventsTemplate>
    </dc:DataCalendar>
    <asp:ListView ID="lstvwPosts" runat="server" DataKeyNames="PostID">
        <ItemTemplate>
            <span style="">PostID:
            <asp:Label ID="PostIDLabel" runat="server" Text='<%# Eval("PostID") %>' />
            <br />
            Username:
            <asp:Label ID="PostUsernameLabel" runat="server" 
                Text='<%# Membership.GetUser(Eval("PostUserID")).UserName %>' />
            <br />
            PostDateTimeCreated:
            <asp:Label ID="PostDateTimeCreatedLabel" runat="server" 
                Text='<%# Eval("PostDateTimeCreated") %>' />
            <br />
            PostGroup:
            <asp:Label ID="PostGroupLabel" runat="server" Text='<%# Eval("PostGroup") %>' />
            <br />
            PostTitle:
            <asp:Label ID="PostTitleLabel" runat="server" Text='<%# Eval("PostTitle") %>' />
            <br />
            PostText:
            <asp:Label ID="PostTextLabel" runat="server" Text='<%# Eval("PostText") %>' />
            <br />
            <br />
            </span>
        </ItemTemplate>
        <AlternatingItemTemplate>
            <span style="">PostID:
            <asp:Label ID="PostIDLabel" runat="server" Text='<%# Eval("PostID") %>' />
            <br />
            Username:
            <asp:Label ID="PostUsernameLabel" runat="server" 
                Text='<%# Membership.GetUser(Eval("PostUserID")).UserName %>' />
            <br />
            PostDateTimeCreated:
            <asp:Label ID="PostDateTimeCreatedLabel" runat="server" 
                Text='<%# Eval("PostDateTimeCreated") %>' />
            <br />
            PostGroup:
            <asp:Label ID="PostGroupLabel" runat="server" Text='<%# Eval("PostGroup") %>' />
            <br />
            PostTitle:
            <asp:Label ID="PostTitleLabel" runat="server" Text='<%# Eval("PostTitle") %>' />
            <br />
            PostText:
            <asp:Label ID="PostTextLabel" runat="server" Text='<%# Eval("PostText") %>' />
            <br />
            <br />
            </span>
        </AlternatingItemTemplate>
        <EmptyDataTemplate>
            <span>No data was returned.</span>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <span style="">PostUsername:
            <asp:TextBox ID="PostUsernameTextBox" runat="server" 
                Text='<%# Bind("PostUserID") %>' />
            <br />
            PostDateTimeCreated:
            <asp:TextBox ID="PostDateTimeCreatedTextBox" runat="server" 
                Text='<%# Bind("PostDateTimeCreated") %>' />
            <br />
            PostGroup:
            <asp:TextBox ID="PostGroupTextBox" runat="server" 
                Text='<%# Bind("PostGroup") %>' />
            <br />
            PostTitle:
            <asp:TextBox ID="PostTitleTextBox" runat="server" 
                Text='<%# Bind("PostTitle") %>' />
            <br />
            PostText:
            <asp:TextBox ID="PostTextTextBox" runat="server" 
                Text='<%# Bind("PostText") %>' />
            <br />
            <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                Text="Insert" />
            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                Text="Clear" />
            <br />
            <br />
            </span>
        </InsertItemTemplate>
        <LayoutTemplate>
            <div ID="itemPlaceholderContainer" runat="server" style="">
                <span ID="itemPlaceholder" runat="server" />
            </div>
            <div style="">
                <asp:DataPager ID="DataPager1" runat="server">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                            ShowNextPageButton="False" ShowPreviousPageButton="False" />
                        <asp:NumericPagerField />
                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" 
                            ShowNextPageButton="False" ShowPreviousPageButton="False" />
                    </Fields>
                </asp:DataPager>
            </div>
        </LayoutTemplate>
        <EditItemTemplate>
            <span style="">PostID:
            <asp:Label ID="PostIDLabel1" runat="server" Text='<%# Eval("PostID") %>' />
            <br />
            PostUsername:
            <asp:TextBox ID="PostUsernameTextBox" runat="server" 
                Text='<%# Bind("PostUserID") %>' />
            <br />
            PostDateTimeCreated:
            <asp:TextBox ID="PostDateTimeCreatedTextBox" runat="server" 
                Text='<%# Bind("PostDateTimeCreated") %>' />
            <br />
            PostGroup:
            <asp:TextBox ID="PostGroupTextBox" runat="server" 
                Text='<%# Bind("PostGroup") %>' />
            <br />
            PostTitle:
            <asp:TextBox ID="PostTitleTextBox" runat="server" 
                Text='<%# Bind("PostTitle") %>' />
            <br />
            PostText:
            <asp:TextBox ID="PostTextTextBox" runat="server" 
                Text='<%# Bind("PostText") %>' />
            <br />
            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                Text="Update" />
            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                Text="Cancel" />
            <br />
            <br />
            </span>
        </EditItemTemplate>
        <SelectedItemTemplate>
            <span style="">PostID:
            <asp:Label ID="PostIDLabel" runat="server" Text='<%# Eval("PostID") %>' />
            <br />
            PostUsername:
            <asp:Label ID="PostUsernameLabel" runat="server" 
                Text='<%# Eval("PostUserID") %>' />
            <br />
            PostDateTimeCreated:
            <asp:Label ID="PostDateTimeCreatedLabel" runat="server" 
                Text='<%# Eval("PostDateTimeCreated") %>' />
            <br />
            PostGroup:
            <asp:Label ID="PostGroupLabel" runat="server" Text='<%# Eval("PostGroup") %>' />
            <br />
            PostTitle:
            <asp:Label ID="PostTitleLabel" runat="server" Text='<%# Eval("PostTitle") %>' />
            <br />
            PostText:
            <asp:Label ID="PostTextLabel" runat="server" Text='<%# Eval("PostText") %>' />
            <br />
            <br />
            </span>
        </SelectedItemTemplate>
    </asp:ListView>
    </asp:Content>

