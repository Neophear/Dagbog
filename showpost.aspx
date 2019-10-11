<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="showpost.aspx.cs" Inherits="user_showpost" Title="Untitled Page" %>
<%@ Import Namespace="Stiig" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" Runat="Server">
    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="ID" DataSourceID="sdsShowPost" CellPadding="4" ForeColor="#333333" GridLines="None" Height="208px" Width="495px">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
        <EditRowStyle BackColor="#999999" />
        <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
        <Fields>
            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" Visible="false" ReadOnly="True" SortExpression="ID" />
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
            <asp:BoundField DataField="Text" HeaderText="Text" SortExpression="Text" />
            <asp:TemplateField HeaderText="CreatedBy" SortExpression="CreatedBy">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CreatedBy") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("CreatedBy") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CreatedDate" HeaderText="CreatedDate" DataFormatString="{0:dd/MM/yyyy HH:mm}" SortExpression="CreatedDate" />
            <asp:TemplateField HeaderText="Kategori" SortExpression="CategoryName">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("CategoryName") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("CategoryName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CheckBoxField DataField="IsFriendly" HeaderText="IsFriendly" SortExpression="IsFriendly" />
            <asp:CheckBoxField DataField="IsPublic" HeaderText="IsPublic" SortExpression="IsPublic" />
            <asp:TemplateField>
                <EditItemTemplate>
                    <asp:LinkButton ID="lnkbtnCancel" runat="server" CommandName="Cancel">Annullér</asp:LinkButton>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="lnkbtnEdit" runat="server" Visible='<%# Membership.GetUser().ProviderUserKey.ToString() == Eval("CreatedBy").ToString() %>' CommandName="Edit">Rediger</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Fields>
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
    </asp:DetailsView>
    <asp:SqlDataSource ID="sdsShowPost" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [vwPostCategory] WHERE ([ID] = @ID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ID" QueryStringField="ID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Repeater ID="rptComments" runat="server" onitemdatabound="rptComments_ItemDataBound" onitemcommand="rptComments_ItemCommand">
        <HeaderTemplate>
            <table>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td>
                    <%# Membership.GetUser(Eval("UserID")).UserName %><br />
                    <span class="dateSmall"><%# Utilities.GetDate((DateTime)Eval("CreatedDate")) %></span>
                </td>
                <td>
                    <%# Eval("Text") %>
                </td>
                <td>
                    <asp:LinkButton CausesValidation="false" ID="DeleteLink" Visible="false" runat="server" CommandName="Delete"
                        CommandArgument='<%# Eval("ID") %>'>Slet</asp:LinkButton>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </table>
        </FooterTemplate>
    </asp:Repeater>
    <asp:LoginView ID="lgnvwComment" runat="server">
        <LoggedInTemplate>
            <asp:TextBox ID="txtbxComment" runat="server" Height="100px" 
                TextMode="MultiLine" Width="250px"></asp:TextBox>
            <br />
            <asp:Button ID="btnComment" runat="server" onclick="btnComment_Click" 
                Text="Kommentér" />
        </LoggedInTemplate>
        <AnonymousTemplate>
            Du skal være logget ind for at kommentere.
        </AnonymousTemplate>
    </asp:LoginView>
</asp:Content>