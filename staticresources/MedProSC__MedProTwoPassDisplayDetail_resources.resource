        <style>
            .medproFont {
                font-size: 1.0em;
                font-weight: bold;
                color: #4a4a56;
                padding-left: 1px;
                font-family: Arial,Helvetica,sans-serif;
            }
            .medproTable{
                border-bottom-style: none;
                border-top-style: solid;
                border-top-color: rgb(219,219, 219);
                border-top-width: 0.666667px;
                margin-top: 20px;
                border: "0";
                cellpadding: "0"; 
                cellspacing: "0";  
                width: 100%;      
            }            
            

        .spinner {
        border: 2px solid black;
        background: rgba(230, 230, 230, 1.0);
        position: fixed;
        top: 50%;
        left: 50%;
        margin-left: -125px; /* half width of the spinner gif */
        margin-top: -82px; /* half height of the spinner gif */
        text-align:center;
        z-index:1234;
        overflow: hidden;
        width: 210px; /* width of the spinner gif */
        height: 210px; /*hight of the spinner gif +2px to fix IE8 issue */
        padding: {5px 5px 2px 25px};
        }
        
        .ui-button-icon-only .ui-icon {
        margin-left: -8px !important;
        margin-top: -8px !important;
        }
        .loading {
            background: transparent;
            border: transparent;
            -webkit-animation:spin 2s linear infinite;
            animation:spin 2s linear infinite;
        }
        @-webkit-keyframes spin { 100% { 
            -webkit-transform:rotate(360deg); 
            }
        }
        @keyframes spin { 100% {
            -webkit-transform:rotate(360deg);
            transform:rotate(360deg);
            }
        }
    </style>