<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="createpost.aspx.cs" Inherits="user_createpost" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">
    <asp:DetailsView ID="dvCreatePost" runat="server" AutoGenerateRows="False" DataKeyNames="ID" DataSourceID="sdsCreatePost" DefaultMode="Insert" OnItemInserting="dvCreatePost_ItemInserting">
        <Fields>
            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
            <asp:TemplateField HeaderText="Titel" SortExpression="Title">
                <InsertItemTemplate>
                    <asp:TextBox ID="txtTitle" runat="server" Text='<%# Bind("Title") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvTitle" ControlToValidate="txtTitle" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Tekst" SortExpression="Text">
                <InsertItemTemplate>
                    <asp:TextBox ID="txtText" runat="server" Text='<%# Bind("Text") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvText" ControlToValidate="txtText" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Kategori" SortExpression="CategoryRefID">
                <InsertItemTemplate>
                    <asp:DropDownList ID="ddlCategory" runat="server" DataSourceID="sdsCategory" AppendDataBoundItems="true" DataTextField="Name" DataValueField="ID">
                        <asp:ListItem Value="0" Text="-Vælg kategori-" Selected="True"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator InitialValue="0" ID="rfvCategory" Display="Dynamic" runat="server"
                        ControlToValidate="ddlCategory" Text="*" ErrorMessage="Du skal vælge kategori"></asp:RequiredFieldValidator>
                    <asp:SqlDataSource ID="sdsCategory" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Categories]"></asp:SqlDataSource>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Kan ses af venner" SortExpression="IsFriendly">
                <InsertItemTemplate>
                    <asp:CheckBox ID="chkbxIsFriendly" runat="server" Checked='<%# Bind("IsFriendly") %>' />
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Kan ses af alle" SortExpression="IsPublic">
                <InsertItemTemplate>
                    <asp:CheckBox ID="chkbxIsPublic" runat="server" Checked='<%# Bind("IsPublic") %>' />
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowInsertButton="True" ButtonType="Button" CancelText="Annuller" InsertText="Opret" />
        </Fields>
    </asp:DetailsView>
    <asp:SqlDataSource ID="sdsCreatePost" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" InsertCommandType="StoredProcedure" InsertCommand="CreatePost" OnInserted="sdsCreatePost_Inserted">
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="LastID" Type="Int32" />
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="Text" Type="String" />
            <asp:Parameter Name="CreatedBy" DbType="Guid" />
            <asp:Parameter Name="CategoryRefID" Type="Int32" />
            <asp:Parameter Name="IsFriendly" Type="Boolean" />
            <asp:Parameter Name="IsPublic" Type="Boolean" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>

