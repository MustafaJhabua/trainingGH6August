
/*
	Copyright (C) Hoefler & Co.
	This software is the property of Hoefler & Co. (H&Co).
	Your right to access and use this software is subject to the
	applicable License Agreement, or Terms of Service, that exists
	between you and H&Co. If no such agreement exists, you may not
	access or use this software for any purpose.
	This software may only be hosted at the locations specified in
	the applicable License Agreement or Terms of Service, and only
	for the purposes expressly set forth therein. You may not copy,
	modify, convert, create derivative works from or distribute this
	software in any way, or make it accessible to any third party,
	without first obtaining the written permission of H&Co.
	For more information, please visit us at http://typography.com.
*/

@font-face {
	font-family: 'HCo Gotham';
	src:url("{!URLFOR($Resource.Woff2, 'woff2/Gotham-Light_Web.woff2')}") format('woff2'),
		url("{!URLFOR($Resource.Woff, 'woff/Gotham-Light_Web.woff')}") format('woff');
	font-weight: 300;
	font-style: normal;
}

@font-face {
	font-family: 'HCo Gotham';
	src:url("{!URLFOR($Resource.Woff2, 'woff2/Gotham-LightItalic_Web.woff2')}") format('woff2'),
		url("{!URLFOR($Resource.Woff, 'woff/Gotham-LightItalic_Web.woff')}") format('woff');
	font-weight: 300;
	font-style: italic;
}

@font-face {
	font-family: 'HCo Gotham';
	src:url("{!URLFOR($Resource.Woff2, 'woff2/Gotham-Book_Web.woff2')}") format('woff2'),
		url("{!URLFOR($Resource.Woff, 'woff/Gotham-Book_Web.woff')}") url('./woff/Gotham-Book_Web.woff') format('woff');
	font-weight: 400;
	font-style: normal;
}

@font-face {
	font-family: 'HCo Gotham';
	src:url("{!URLFOR($Resource.Woff2, 'woff2/Gotham-BookItalic_Web.woff2')}") format('woff2'),
		url("{!URLFOR($Resource.Woff, 'woff/Gotham-BookItalic_Web.woff')}") format('woff');
	font-weight: 400;
	font-style: italic;
}

@font-face {
	font-family: 'HCo Gotham';
	src:url("{!URLFOR($Resource.Woff2, 'woff2/Gotham-Medium_Web.woff2')}") format('woff2'),
		url("{!URLFOR($Resource.Woff, 'woff/Gotham-Medium_Web.woff')}") format('woff');
	font-weight: 500;
	font-style: normal;
}

@font-face {
	font-family: 'HCo Gotham';
	src:url("{!URLFOR($Resource.Woff2, 'woff2/Gotham-MediumItalic_Web.woff2')}") format('woff2'),
		url("{!URLFOR($Resource.Woff, 'woff/Gotham-MediumItalic_Web.woff')}") format('woff');
	font-weight: 500;
	font-style: italic;
}

@font-face {
	font-family: 'HCo Gotham';
	src:url("{!URLFOR($Resource.Woff2, 'woff2/Gotham-Bold_Web.woff2')}") format('woff2'),
		url("{!URLFOR($Resource.Woff, 'woff/Gotham-Bold_Web.woff')}") format('woff');
	font-weight: 700;
	font-style: normal;
}

@font-face {
	font-family: 'HCo Gotham';
	src:url("{!URLFOR($Resource.Woff2, 'woff2/Gotham-BoldItalic_Web.woff2')}") format('woff2'),
		url("{!URLFOR($Resource.Woff, 'woff/Gotham-BoldItalic_Web.woff')}") format('woff');
	font-weight: 700;
	font-style: italic;
}
/* fallback */
@font-face {
  font-family: 'Material Icons';
  font-style: normal;
  font-weight: 400;
  src: url("{!URLFOR($Resource.materialcssforRequestForm)}") format('woff2');
}

.material-icons {
  font-family: 'Material Icons';
  font-weight: normal;
  font-style: normal;
  font-size: 24px;
  line-height: 1;
  letter-spacing: normal;
  text-transform: none;
  display: inline-block;
  white-space: nowrap;
  word-wrap: normal;
  direction: ltr;
  -webkit-font-feature-settings: 'liga';
  -webkit-font-smoothing: antialiased;
}