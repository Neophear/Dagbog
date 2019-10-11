<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="profile.aspx.cs" Inherits="user_profile" Title="Untitled Page" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="lblSettingsSaved" Visible="false" runat="server" Text="Dine indstillinger blev gemt"></asp:Label>
    <asp:TabContainer ID="TabContainer1" runat="server">
        <asp:TabPanel ID="TapPanel1" runat="server" HeaderText="Indstillinger">
            <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            Standard privacy:
                        </td>
                        <td>
                            <asp:RadioButtonList ID="rblGroup" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="Privat" Value="pr"></asp:ListItem>
                                <asp:ListItem Text="Venner" Value="fr"></asp:ListItem>
                                <asp:ListItem Text="Offentlig" Value="pu"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Allow friendrequests:
                        </td>
                        <td>
                            <asp:RadioButtonList ID="rblFriendRequest" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="Tilladt" Value="True"></asp:ListItem>
                                <asp:ListItem Text="Ikke tilladt" Value="False"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Vis fødselsdag og alder:
                        </td>
                        <td>
                            <asp:RadioButtonList ID="rblShowBirthAge" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="Vis fødselsdag og alder" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Vis kun alder" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Skjul begge" Value="2"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:TabPanel>
        <asp:TabPanel ID="TapPanel2" runat="server" HeaderText="Konto">
            <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            E-mail:
                        </td>
                        <td>
                            <asp:TextBox ID="txtbxEmail" runat="server" ValidationGroup="Settings"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Password (Kun skriv noget hvis du vil ændre det):
                        </td>
                        <td>
                            <asp:TextBox ID="txtbxOldPassword" TextMode="Password" runat="server" 
                                ValidationGroup="Settings"></asp:TextBox><br />
                            <asp:TextBox ID="txtbxNewPass1" TextMode="Password" runat="server" 
                                ValidationGroup="Settings"></asp:TextBox><br />
                            <asp:TextBox ID="txtbxNewPass2" TextMode="Password" runat="server" 
                                ValidationGroup="Settings"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:TabPanel>
    </asp:TabContainer>
    <asp:Button ID="btnSubmit" runat="server" Text="Gem" 
        onclick="btnSubmit_Click" />
</asp:Content>