<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" Title="Untitled Page" %>
<%@ Import Namespace="Stiig" %>
<%@ Register Src="~/Controls/UserLink.ascx" TagPrefix="uc1" TagName="UserLink" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">
    <h1>Nyeste</h1>
    <asp:ListView ID="lstvwPosts" runat="server" DataKeyNames="ID" 
        DataSourceID="sdsPosts" GroupItemCount="3">
        <EmptyDataTemplate>
            <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <EmptyItemTemplate>
            <td runat="server" />
        </EmptyItemTemplate>
        <ItemTemplate>
            <td class="frontpagePosts" runat="server">
                <asp:HyperLink ID="hplPostTitle" CssClass="frontPostTitle" NavigateUrl='<%# "~/showpost.aspx?id=" + Eval("ID") %>' runat="server"><%# Eval("Title") %></asp:HyperLink><br />
                <asp:HyperLink ID="hplPostText" CssClass="frontPostText" NavigateUrl='<%# "~/showpost.aspx?id=" + Eval("ID") %>' runat="server"><%# Utilities.CutText(Eval("Text").ToString(), "...", 30, true) %></asp:HyperLink><br />
                <uc1:UserLink runat="server" UserID='<%# Guid.Parse(Eval("CreatedBy").ToString()) %>' ID="UserLink" /> | 
                <asp:Label ID="CreatedDateLabel" runat="server" Text='<%# Utilities.GetDate((DateTime)Eval("CreatedDate")) %>' />
                <br />
                Kategory:
                <asp:Label ID="CategoryNameLabel" runat="server" Text='<%# Eval("CategoryName") %>' />
                <br />
                <asp:CheckBox ID="IsFriendlyCheckBox" runat="server" Checked='<%# Eval("IsFriendly") %>' Enabled="false" Text="IsFriendly" />
                <br />
                <asp:CheckBox ID="IsPublicCheckBox" runat="server" Checked='<%# Eval("IsPublic") %>' Enabled="false" Text="IsPublic" />
                <br />
            </td>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table id="groupPlaceholderContainer" runat="server" border="1" style="background-color: #FFFFFF;border-collapse: separate;border-spacing:10px; border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr id="groupPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
        <GroupTemplate>
            <tr id="itemPlaceholderContainer" runat="server">
                <td id="itemPlaceholder" runat="server">
                </td>
            </tr>
        </GroupTemplate>
        </asp:ListView>
    <asp:SqlDataSource ID="sdsPosts" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TOP 6 * FROM [vwPostCategory] WHERE ([IsPublic] = 1) ORDER BY [CreatedDate] DESC">
        <SelectParameters>
            <asp:Parameter DefaultValue="False" Name="Deleted" Type="Boolean" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>