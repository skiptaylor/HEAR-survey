@import url(https://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,700italic,300,400,600,700);

body {
	padding-top: 0px;
   font-family: 'Open Sans', helvetica, sans-serif;
	font-size: 14px;
	line-height: 22px;
	margin: 0px;
	background-color: #ffffff;
   -webkit-transition: all .8s ease-in-out;
        -o-transition: all .8s ease-in-out;
           transition: all .8s ease-in-out;
}

.page-ease {
   -webkit-transition: all .3s ease-in-out;
        -o-transition: all .3s ease-in-out;
           transition: all .3s ease-in-out;
}


.container-white 	{
	background: white;
	padding: 14px 0px 36px 0px;
	margin: 0px;
	border: none;
	border-top: 1px solid silver;
}

.container {
  color: #000000;
}

.navbar-inverse ul.nav li.a:hover 	{
	color: #ffffff;
}

.navbar-inverse .brand,
.navbar-inverse .nav > li > a {
  color: #c0c0c0;
  margin: 0px;
}

.navbar-inverse .brand:hover,
.navbar-inverse .nav > li > a:hover,
.navbar-inverse .brand:focus,
.navbar-inverse .nav > li > a:focus,
.navbar-inverse .brand:active,
.navbar-inverse .nav > li > a:active {
  color: red;
}

.navbar-inverse .brand {
  color: #ffffff;
}

.navbar-inverse .navbar-text {
}

.navbar-inverse .nav > li > a:focus,
.navbar-inverse .nav > li > a:hover,
.navbar-inverse .nav > li > a:active {
  color: #ffffff;
  background-color: transparent;
}

.navbar-inverse .nav .active > a,
.navbar-inverse .nav .active > a:hover,
.navbar-inverse .nav .active > a:focus,
.navbar-inverse .nav .active > a:active {
  color: #ffffff;
  background-color: transparent;
}

.navbar-inverse .navbar-link {
}

.navbar-inverse .navbar-link:hover,
.navbar-inverse .navbar-link:focus,
.navbar-inverse .navbar-link:active {
  color: red;
}


/*.aTabs > li.active > a,
.aTabs > li.active > a:hover,
.aTabs > li.active > a:focus {
  cursor: default;
  border: 1px solid #bbbbbb;
  border-bottom-color: transparent;
}
*/




/*@media (max-width: 980px) { body { padding-top: 0px; } }*/

/*ul li, ol li	{
	line-height: 1.4em;
	margin-bottom: 9px;
}
*/
p, h2, h3, h4, h5, h6 	{
	font-family: 'Open Sans', helvetica, sans-serif;
	margin-bottom: 12px;
}

h1	{
	font-family: 'Open Sans', sans-serif;
	margin: 0px 0px 18px 0px;
	font-size: 2.7em;
	line-height: 1.2em;
	font-weight: 400;
	letter-spacing: -1px;
}

h2	{
	font-family: 'Open Sans', sans-serif;
	margin: 0;
	font-size: 2em;
	line-height: 1.2em;
	font-weight: 700;
	letter-spacing: -1px;
}


h1.page-header	{
	font-size: 2.4em;
	color: #08297b;
	margin: 18px 0 22px 0;
	line-height: 1.15em;
	padding-bottom: 8px;
	border-bottom: 1px solid #1abd9c;
}

.textfield	{
	font-family: 'Open Sans', helvetica, sans-serif;
}

h4	{
	font-family: 'Open Sans', helvetica, sans-serif;
	font-weight: 600;
	font-size: 20px;
	color: #7f8287;
}
h5	{
	font-weight: 400;
	font-size: 1.4em;
	padding: 0;
	margin: 0px 0 14px 0;
}
h6	{
	font-weight: 400;
	font-size: 1.8em;
	line-height: 1.2em;
	padding: 0 0 10px 0;
	margin: 0;
}
h3	{
	font-size: 1.8em;
	font-family: 'Open Sans', helvetica, sans-serif;
	font-weight: 400;
	line-height: 1.2em;
	margin: 0 0 9px 0;
	padding: 0;
}

blockquote	{
	margin: 9px 0px 30px 0;
	padding: 9px 9px 9px 18px;
	border-left: 5px solid #1abd9c;
}
blockquote.box	{
	margin: 9px 0px 30px 0;
	padding: 1rem 1rem 1rem 2rem;
	border: 1px solid #1abd9c;
	border-left: 5px solid #1abd9c;
}

.under-link a	{
	color: #0088cc;
	font-weight: 600;
	text-decoration: none;
	padding-bottom: 1px;
	margin-bottom: -2px;
	border: none;
	border-bottom: 1px dotted #007dbc;
	line-height: 1.8em;
    -webkit-transition: all 0.15s ease-in-out;
       -moz-transition: all 0.15s ease-in-out;
         -o-transition: all 0.15s ease-in-out;
            transition: all 0.15s ease-in-out;
}

.under-link a:hover	{
	text-decoration: none;
	color: black;
	border-bottom: 1px solid black;
}

.under-link a:active	{
	text-decoration: none;
	color: gray;
	border-bottom: 1px solid gray;
}

footer	{
	color: black;
	font-size: .85em;
	line-height: 2.8em;
	text-align: center;
	padding: 24px 0;
	margin: 2rem 0 0 0;
	border: none;
	border-top: 1px solid silver;
   background-image: -moz-linear-gradient(top, #e2e4ef, #ffffff);
   background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#e2e4ef), to(#ffffff));
   background-image: -webkit-linear-gradient(top, #e2e4ef, #ffffff);
   background-image: -o-linear-gradient(top, #e2e4ef, #ffffff);
   background-image: linear-gradient(to bottom, #e2e4ef, #ffffff);
   background-repeat: repeat-x;
   filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='##e2e4ef', endColorstr='#ffffff', GradientType=0);
}

.link-row:hover {
	cursor: pointer;
}

.lead	{
	color: black;
	font-weight: 300;
	font-size: 1.4em;
	line-height: 1.4em;
	margin-bottom: 14px;
}

hr	{
	margin: 9px 0px;
	border-top: 1px solid #cccccc;
	border-bottom: 1px solid white;
}

.clear {
	clear: all;
}

dl dd	{
	margin-bottom: 9px;
}

.table.w th,
.table.w td	{
  border-top: 1px solid #ffffff;
}

#date_due_month, #date_due_day, #date_due_year,
#invoice_date_month, #invoice_date_day, #invoice_date_year,
#date_paid_month, #date_paid_day, #date_paid_year	{
	width: 90px;
}

.well	{
	margin: 32px 0;
	padding: 18px 18px 6px 24px;
}

.sign	{
	padding: 32px 24px 22px 36px;
}

label	{
	font-weight: 600;
}

p.question	{
	font-size: 1.3em;
	font-weight: 600;
	font-style: italic;
	margin-top: 24px;
}

p.answer	{
	margin-left: 32px;
}

.padleft	{
	padding-left: 18px;
	margin-bottom: 14px;
}

.padright	{
	padding-right: 32px;
	margin-bottom: 14px;
}

.green	{
	color: #1abd9c;
}


.pic-border 	{
	border: 1px solid gray;
 -webkit-box-shadow: 0 3px 5px rgba(0, 0, 0, 0.3);
    -moz-box-shadow: 0 3px 5px rgba(0, 0, 0, 0.3);
         box-shadow: 0 3px 5px rgba(0, 0, 0, 0.3);
}

.semi-bold	{
	font-weight: 600;
}

.half-space p	{
	margin-bottom: 32px;
}

.horz	{
	float: left;
	text-align: right;
	width: 180px;
	margin-right: 12px;
	margin-top: 4px;
}

select.month {
	width: 70px;
	margin-right: 3px;
	margin-bottom: 0;
}
select.day {
	width: 70px;
	margin-right: 3px;
	margin-bottom: 0;
}
select.year {
	width: 90px;
	margin-right: 3px;
	margin-bottom: 0;
}


.flash	{
	color: #dc0042;
	font-weight: 600;
	font-size: 0.85em;
}

.sign-in {
	padding: 12px;
  background-color: #ffffff;
  border: 1px solid #999;
  border: 1px solid rgba(0, 0, 0, 0.3);
  -webkit-border-radius: 6px;
     -moz-border-radius: 6px;
          border-radius: 6px;
  outline: none;
  -webkit-box-shadow: 0 3px 7px rgba(0, 0, 0, 0.3);
     -moz-box-shadow: 0 3px 7px rgba(0, 0, 0, 0.3);
          box-shadow: 0 3px 7px rgba(0, 0, 0, 0.3);
  -webkit-background-clip: padding-box;
     -moz-background-clip: padding-box;
          background-clip: padding-box;
}

.input-box	{
   border: 1px solid #999;
   -webkit-border-radius: 22px;
      -moz-border-radius: 22px;
           border-radius: 22px;
}



.alert	{
	position: absolute;
	top: 10%;
	left: 10%;
	color: white;
	background-color: #336df0;
	padding: 12px;
   -webkit-border-radius: 6px;
      -moz-border-radius: 6px;
           border-radius: 6px;
}

.rotated	{
	background-color: white;
   -webkit-box-shadow: 0 3px 7px rgba(0, 0, 0, 0.5);
      -moz-box-shadow: 0 3px 7px rgba(0, 0, 0, 0.5);
           box-shadow: 0 3px 7px rgba(0, 0, 0, 0.5);
	transform: rotate(-4deg);
	-ms-transform: rotate(-4deg); /* IE 9 */
	-webkit-transform: rotate(-4deg); /* Safari and Chrome */
}

.password-show	{
	color: #a72600;
	font-weight: 400;
	font-size: 1.4em;
}

.short	{
	line-height: 1.9em;
	margin: 0;
	padding: 0 0 9px 0;
}

.help-inline	{
	font-size: .85em;
	color: gray;
}

.resume-view	{
	float: left;
	clear: both;
	text-align: right;
	width: 200px;
	margin-right: 18px;
	line-height: 3em;
	margin-top: -7px;
}

.trans1	{
	opacity: 0.1;
}

.trans4	{
	opacity: 0.4;
}







div#alert {
	display: none;
	position: absolute;
	width: 100%;
	font-family: 'Open Sans', sans-serif;
	line-height: 3em;
	display: block;
	background-color: #336df0;
	opacity: 0.8;
	padding: 3px 3px;
	margin: 0 auto 0 auto;
	text-align: center;
	color: #ffffff;
	font-weight: 800;
	z-index: 999;
}


/*div#ground	{
	background-image: url("../img/eCDweb.jpg");
	background-repeat: no-repeat;
	background-size: cover;
	background-position: center center;
	position: relative;
   -webkit-transition: all .3s ease-in-out;
        -o-transition: all .3s ease-in-out;
           transition: all .3s ease-in-out;
}
*/
input, textarea, select	{
	border: 1px solid #92bd97 !important;
	outline: 0px solid #92bd97 !important;
   -webkit-border-radius: 6px;
      -moz-border-radius: 6px;
           outline-radius: 6px;
}


.dropdown-item {
  display: block;
  width: 100%;
  padding: 0.25rem 1.5rem;
  clear: both;
  font-weight: 400;
  color: #212529;
  text-align: inherit;
  white-space: nowrap;
  background-color: transparent;
  border: 0;
}

.dropdown-item:hover, .dropdown-item:focus {
  color: #ffffff;
  text-decoration: none;
  background-color: #1abd9c;
}

.dropdown-item.active, .dropdown-item:active {
  color: #fff;
  text-decoration: none;
  background-color: #007bff;

