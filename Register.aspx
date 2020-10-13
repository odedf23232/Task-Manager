<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MyWebApp1.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="frame">
        <div class="frame" style=" margin: auto; background-color: #ccf5ff; border-width:3px; border-style: solid; border-color: #000000; border-radius: 10px; padding: 30px; width: 50%">
            <h4 align="center">Create a new account</h4>
            <img class="rounded mx-auto d-block" alt="Create_account" src="Images/create-account.jpg" style="width: 150px; height: 150px"/>
            <hr />

            <div class="form-group" align="center">
                <div class="col-xs-5 col-sm-6">
                    <asp:TextBox runat="server" ID="Fname" CssClass="form-control" 
                        pattern="[A-Za-z]{1,}" title="Only Alphabets" placeholder="First name"/>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="FName" Display="Dynamic"
                        CssClass="text-danger" ErrorMessage="First name can not be blank." />
                </div>
            </div>
            <div class="form-group" align="center">
                <div class="col-xs-5 col-sm-6">
                    <asp:TextBox runat="server" ID="Lname" CssClass="form-control" 
                        pattern="[A-Za-z]{1,}" title="Only Alphabets" placeholder="Last name"/>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="LName" Display="Dynamic"
                        CssClass="text-danger" ErrorMessage="Last name can not be blank." />
                </div>
            </div>

            <div class="form-group" align="center">
                <div class="col-xs-5 col-sm-6">
                    <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" 
                        pattern="[a-zA-Z0-9!#$%&'*+\/=?^_`{|}~.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*" title="format: xxx@xxx.xxx" placeholder="Email"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Email" Display="Dynamic"
                        CssClass="text-danger" ErrorMessage="The email field is required." />            
                </div>
            </div>
            <div class="form-group" align="center">
                <div class="col-xs-5 col-sm-6">
                    <asp:TextBox runat="server" ID="Password" CssClass="form-control" TextMode="Password" pattern="^(?=.*\d)(?=.*[a-zA-Z]).{6,10}$" title="Must contain at least one number and one letter, lenght is 6-10 characters" placeholder="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" Display="Dynamic"
                        CssClass="text-danger" ErrorMessage="The password field is required." />            
                </div>
            </div>
            <div class="form-group" align="center">
                <div class="col-xs-5 col-sm-6">
                    <asp:Button runat="server" OnClick="Create_User_Click" Text="Register" CssClass="btn btn-primary btn-block" /><br />
                    <a href="Login.aspx"> Back</a>
                </div>
            </div>
            <div class="form-group" align="center">
                <div class="col-xs-5 col-sm-6">
                    <asp:Panel runat="server" id="TestPanel" visible="false" style="position:center">
                        <asp:Label runat="server" id="CheckText" ForeColor="OrangeRed" />
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
