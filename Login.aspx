<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MyWebApp1.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="inc/bootstrap.min.css" rel="stylesheet" />
    <div class="frame">
        <div class="frame" style=" margin: auto; background-color: #ccf5ff; border-width:3px; border-style: solid; border-color: #006680; border-radius: 10px; padding: 30px; width: 50%">
            <h1 align="center">Task Management System</h1><br/>
            <img class="rounded mx-auto d-block" alt="Calendar_img" src="Images/task_manage.jpg" style="width: 173px; height: 130px"/><br/>           
            <h4 align="center">Sign In</h4>
            <hr />

            <div class="form-group" align="center">
                <div class="col-xs-5 col-sm-6 ">
                    <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" 
                        pattern="[a-zA-Z0-9!#$%&'*+\/=?^_`{|}~.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*" title="format: xxx@xxx.xxx" placeholder="Email"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                         CssClass="text-danger" ErrorMessage="The email field is required." />
                </div>
            </div>
            <div class="form-group" align="center">
                <div class="col-xs-5 col-sm-6 ">
                    <asp:TextBox runat="server" ID="Password" CssClass="form-control" TextMode="Password" 
                        placeholder="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" 
                        CssClass="text-danger" ErrorMessage="The password field is required." />
                </div>
            </div>
            <div class="form-group" align="center">
                <div class="col-xs-5 col-sm-6 ">
                    <asp:Button runat="server" OnClick="Submit_Login" Text="Login" CssClass="btn btn-primary btn-block" /><br />
                    <p>Dont have an account yet?</p>
                    <a href="Register.aspx">Sign Up</a> 
                </div>
            </div>

            <div class="form-group" align="center">
                <div class="col-xs-5 col-sm-6 ">
                    <asp:Panel runat="server" id="TestPanel" visible="false" style="position:center">
                        <asp:Label runat="server" id="CheckText" ForeColor="OrangeRed" />
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
