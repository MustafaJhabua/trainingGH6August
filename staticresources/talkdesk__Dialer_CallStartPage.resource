<html>
<head>
    <title>Starting a call </title>
</head>
<style type="text/css">
		#loading-wrapper {
	      top: 0;
	      left: 0;
	      position: absolute;
	      width: 100%;
	      height: 100%;
	      background-color: #172241;
	      z-index: 1100;
	    }

	    #loading {
	      position: absolute;
	      top: 50%;
	      left: 50%;
	      transform: translate(-50%, -0%);
	    }

	    #loading svg {
	      fill: white;
	      width: 40px;
	      height: 40px;
	      animation: animation 4s infinite cubic-bezier(0.68, -0.55, 0.265, 1.55);
	    }

	    #loading #chat-icon {
	      position: absolute;
	      transform-origin: bottom left;
	      margin-left: -60px;
	    }

	    #loading #phone-icon {
	      position: absolute;
	      transform-origin: bottom right;
	      animation-delay: -1s !important;
	      margin-left: 20px;
	    }

	    #loading #video-icon {
	      position: absolute;
	      transform-origin: bottom left;
	      animation-delay: -2s !important;
	      margin-left: -60px;
	    }

	    #loading #email-icon {
	      position: absolute;
	      transform-origin: bottom right;
	      animation-delay: -3s !important;
	      margin-left: 20px;
	    }

    	@keyframes animation {
    		 0% {
    		 		transform: rotate(0deg) translate(0, 0) scale(0);
        			opacity: 0;
    		}
        	25% {
        			transform: rotate(0deg) translate(0, -24px) scale(1);
        			opacity: 1;
    		}
        	50% {
        		transform: rotate(-2deg) translate(0, -48px) scale(1);
        		opacity: 0;
    		}
    		100% {
    			transform: rotate(-2deg) translate(0, -48px) scale(1);
       			opacity: 0;
    		}


</style>
<body>
<div id="loading-wrapper">
    <div id="loading">
        <svg id="chat-icon" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
            <path d="M20 2H4c-1.1 0-1.99.9-1.99 2L2 22l4-4h14c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zM6 9h12v2H6V9zm8 5H6v-2h8v2zm4-6H6V6h12v2z"/>
            <path d="M0 0h24v24H0z" fill="none"/>
        </svg>
        <svg id="phone-icon" width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M20 15.5C18.75 15.5 17.55 15.3 16.43 14.93C16.08 14.82 15.69 14.9 15.41 15.17L13.21 17.37C10.38 15.93 8.06 13.62 6.62 10.78L8.82 8.57C9.1 8.31 9.18 7.92 9.07 7.57C8.7 6.45 8.5 5.25 8.5 4C8.5 3.45 8.05 3 7.5 3H4C3.45 3 3 3.45 3 4C3 13.39 10.61 21 20 21C20.55 21 21 20.55 21 20V16.5C21 15.95 20.55 15.5 20 15.5Z" fill="white"/>
            <path d="M12 3C17.5 3 21 7.5 21 12H19C19 8.17017 16 5 12 5V3Z" fill="white"/>
            <path d="M12 7C14.5 7 17 9 17 12H15C15 10.5 14 9 12 9V7Z" fill="white"/>
        </svg>
        <svg id="video-icon" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
            <path d="M0 0h24v24H0z" fill="none"/>
            <path d="M17 10.5V7c0-.55-.45-1-1-1H4c-.55 0-1 .45-1 1v10c0 .55.45 1 1 1h12c.55 0 1-.45 1-1v-3.5l4 4v-11l-4 4z"/>
        </svg>
        <svg id="email-icon" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
            <path d="M20 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z"/>
            <path d="M0 0h24v24H0z" fill="none"/>
        </svg>
    </div>
</div>
<script>

			let receiveMessage = function(event){
				window.location.replace("td+tel:" + event.data);
				setTimeout(function(){ window.close()}, 2000);
			}

			window.addEventListener('message', receiveMessage);


</script>
</body>
</html>
