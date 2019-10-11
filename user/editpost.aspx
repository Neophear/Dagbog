<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="editpost.aspx.cs" Inherits="user_editpost" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:TextBox ID="txtbxTitle" MaxLength="32" runat="server"></asp:TextBox><br />
    <asp:RequiredFieldValidator ID="reqfvalTxtbxTitle" runat="server" ErrorMessage="Du skal indtaste en titel!" ValidationGroup="Post" SetFocusOnError="True" ControlToValidate="txtbxTitle"></asp:RequiredFieldValidator>
    <br />
    <asp:TextBox ID="txtbxPost" runat="server" Height="120px" 
        TextMode="MultiLine" Width="200px"></asp:TextBox><br />
    <asp:RequiredFieldValidator ID="reqfvalTxtbxPost" runat="server" 
        ErrorMessage="Du skal indtaste noget!" ControlToValidate="txtbxPost" 
        SetFocusOnError="True" ValidationGroup="Post"></asp:RequiredFieldValidator>    
    <asp:HiddenField ID="hdnfldPostID" runat="server" />
    <br />
    <asp:RadioButtonList ID="rblGroup" runat="server">
        <asp:ListItem Text="Privat" Value="pr"></asp:ListItem>
        <asp:ListItem Text="Venner" Value="fr"></asp:ListItem>
        <asp:ListItem Text="Offentlig" Value="pu"></asp:ListItem>
    </asp:RadioButtonList>
    <br />
    <asp:Button ID="btnSubmitPost" ValidationGroup="Post" runat="server" Text="Submit" 
    onclick="btnSubmitPost_Click" />
    <asp:Button ID="btnCancel" runat="server" 
        Text="Annuller" onclick="btnCancel_Click" />
</asp:Content>

