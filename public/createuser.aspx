<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="createuser.aspx.cs" Inherits="public_createuser" Title="Untitled Page" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" 
        oncreateduser="CreateUserWizard1_CreatedUser" 
    CancelDestinationPageUrl="~/Default.aspx" 
    ContinueDestinationPageUrl="~/Default.aspx" 
    FinishDestinationPageUrl="~/Default.aspx" 
    UnknownErrorMessage="Brugeren blev ikke oprettet. Prøv igen." 
    UserNameLabelText="Brugernavn:" 
    CompleteSuccessText="Din bruger blev oprettet." 
    ConfirmPasswordLabelText="Bekræft password:" ContinueButtonText="Fortsæt" 
    CreateUserButtonText="Opret bruger" 
    DuplicateEmailErrorMessage="E-mailen er allerede i brug. Vælg en anden." 
    DuplicateUserNameErrorMessage="Indtast venligst et andet brugernavn." 
    FinishCompleteButtonText="Afslut" FinishPreviousButtonText="Tilbage" 
    InvalidEmailErrorMessage="Indtast venligst en valid e-mail." 
        ConfirmPasswordCompareErrorMessage="Begge passwords skal være ens." 
        ConfirmPasswordRequiredErrorMessage="Du skal bekræfte dit password." 
        EmailRegularExpressionErrorMessage="Indtast venligst en anden e-mail." 
        EmailRequiredErrorMessage="E-mail er påkrævet." 
        InvalidPasswordErrorMessage="Minimum password længde: {0}." 
        PasswordRegularExpressionErrorMessage="Indtast venligst et andet password." 
        PasswordRequiredErrorMessage="Password er påkrævet." 
        StartNextButtonText="Næste" StepNextButtonText="Næste" 
        StepPreviousButtonText="Tilbage" 
        UserNameRequiredErrorMessage="Brugernavn er påkrævet.">
    <WizardSteps>
        <asp:CreateUserWizardStep runat="server" >
            <ContentTemplate>
                <table border="0">
                    <tr>
                        <td align="center" colspan="2">
                            Opret ny bruger:
                        </td>
                        <td>
                        
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Brugernavn:</asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                                ControlToValidate="UserName" ErrorMessage="Brugernavn er påkrævet." 
                                ToolTip="Brugernavn er påkrævet." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                                ControlToValidate="Password" ErrorMessage="Password er påkrævet." 
                                ToolTip="Password er påkrævet." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="ConfirmPasswordLabel" runat="server" 
                                AssociatedControlID="ConfirmPassword">Bekræft password:</asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" 
                                ControlToValidate="ConfirmPassword" 
                                ErrorMessage="Du skal bekræfte dit password." 
                                ToolTip="Du skal bekræfte dit password." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-mail:</asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="Email" runat="server"></asp:TextBox>
                            <asp:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender2" runat="server" 
                                TargetControlID="Email" WatermarkCssClass="txtbxBlur" 
                                WatermarkText="navn@domæne.com">
                            </asp:TextBoxWatermarkExtender>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="EmailRequired" runat="server" 
                                ControlToValidate="Email" ErrorMessage="E-mail er påkrævet." 
                                ToolTip="E-mail er påkrævet." ValidationGroup="CreateUserWizard1" 
                                Display="Dynamic">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                ErrorMessage="*" ControlToValidate="Email" Display="Dynamic" 
                                ToolTip="E-mailen er ikke korrekt." 
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                                ValidationGroup="CreateUserWizard1"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="GenderLabel" runat="server" AssociatedControlID="IsMaleRBL">Køn:</asp:Label>
                        </td>
                        <td>
                            <asp:RadioButtonList ID="IsMaleRBL" runat="server" ValidationGroup='CreateUserWizard1' RepeatDirection="Horizontal">
                                <asp:ListItem Text="Mand" Value="True"></asp:ListItem>
                                <asp:ListItem Text="Kvinde" Value="False"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="IsMaleRequired" runat="server" 
                                ControlToValidate="IsMaleRBL" ErrorMessage="Du skal vælge dit køn." 
                                ToolTip="Du skal vælge dit køn." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="BirthdayLabel" runat="server" AssociatedControlID="IsMaleRBL">Fødselsdag:</asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="BirthdayTextBox" ValidationGroup="CreateUserWizard1" runat="server"></asp:TextBox>
                            <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server"
                                TargetControlID="BirthdayTextBox"
                                Mask="99/99/9999"
                                MessageValidatorTip="true"
                                MaskType="Date"
                                DisplayMoney="Left"
                                AcceptNegative="Left"
                                ErrorTooltipEnabled="True" />
                            <asp:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server" 
                                TargetControlID="BirthdayTextBox" WatermarkCssClass="txtbxBlur" 
                                WatermarkText="DD-MM-ÅÅÅÅ">
                            </asp:TextBoxWatermarkExtender>
                        </td>
                        <td>
                            <asp:MaskedEditValidator ID="MaskedEditValidator1" runat="server"
                                ControlExtender="MaskedEditExtender1"
                                ControlToValidate="BirthdayTextBox"
                                EmptyValueMessage="*"
                                InvalidValueMessage="*"
                                TooltipMessage="*"
                                EmptyValueBlurredText="*"
                                InvalidValueBlurredMessage="*"
                                ValidationGroup="CreateUserWizard1" />
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="3">
                            <asp:CompareValidator ID="PasswordCompare" runat="server" 
                                ControlToCompare="Password" ControlToValidate="ConfirmPassword" 
                                Display="Dynamic" ErrorMessage="Begge passwords skal være ens." 
                                ValidationGroup="CreateUserWizard1"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="3" style="color:Red;">
                            <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            <CustomNavigationTemplate>
                <table border="0" cellspacing="5" style="width:100%;height:100%;">
                    <tr align="right">
                        <td align="right" colspan="0">
                            <asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext" 
                                Text="Opret bruger" ValidationGroup="CreateUserWizard1" />
                        </td>
                    </tr>
                </table>
            </CustomNavigationTemplate>
        </asp:CreateUserWizardStep>
        <asp:CompleteWizardStep runat="server" />
    </WizardSteps>
</asp:CreateUserWizard>
</asp:Content>

