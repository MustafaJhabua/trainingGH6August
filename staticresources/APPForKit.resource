$(document).ready(function() {
    $("#form3").hide(), $("#form4").hide(), $(".validate").click(function() {
        if($('#npi').hasClass('warning_red'))
        {
            return false;
        }
        if ($("input[name=typeOfCancer]:checked").val()) {
            if ($(".cancer-type").remove(), !t($("#sEmail").val())) return $("#sEmail").closest("div").find("p").remove(), $("#sEmail").closest("div").append('<p class="error-msg">Invalid Email Address</p>'), !1;
            $("#sEmail").closest("div").find("p").remove(), $(".form-one input").each(function() {
                if ("" == $(this).val()) return $(this).addClass("warning_red"), $(this).closest("div").find("p").remove(), $(this).closest("div").append('<p class="error-msg">This field is required.</p>'), !1;
                $(this).removeClass("warning_red"), $(this).closest("div").find("p").remove()
            }), $(".form-one input[type=text]").hasClass("warning_red") || ($(".validate .stepwizard-step").hide(500), $("#two").removeClass("btn-default"), $("#two").addClass("btn-primary"), $(".form-two").show(500), $(".form-one").hide(500), "one" == $(this).attr("id") ? ($("#next").show(500), $("#two").removeClass("btn-primary"), $("#two").addClass("btn-default"), $(".form-one").show(500), $(".form-two").hide(500)) : ($(this).removeClass("btn-default"), $(".form-two").show(500), $(".form-one").hide(500), $("#next").hide(500)))
        } else $(".cancer-type").remove(), $("#cancer-type").append('<div class="col-md-12 text-center cancer-type error-msg">Please select cancer type</div>'), $(".form-one input").each(function() {
            "" == $(this).val() ? ($(this).addClass("warning_red"), $(this).closest("div").find("p").remove(), $(this).closest("div").append('<p class="error-msg">This field is required.</p>')) : ($(this).removeClass("warning_red"), $(this).closest("div").find("p").remove())
        })
    }),$("#SubmitButton").click(function() {
        if ($(".form-two input[type=text]").each(function() {
                "" == $(this).val() ? ($(this).addClass("warning_red"), $(this).closest("div").find("p").remove(), $(this).closest("div").append('<p class="error-msg">This field is required.</p>')) : ($(this).removeClass("warning_red"), $(this).closest("div").find("p").remove())
            }), !$(".form-two input[type=text]").hasClass("warning_red")) {
            if (!t($("#pcEmail").val())) return $("#pcEmail").closest("div").find("p").remove(), $("#pcEmail").closest("div").append('<p class="error-msg">Invalid Email Address</p>'), !1;
            $("#pcEmail").closest("div").find("p").remove(), $("#two").removeClass("btn-default"), $("#two").addClass("btn-primary"), $("#form3").show(500), $(".form-one").hide(500),$(".cancer-type-container").hide(500);
            
        }
    }), $(".custom-button .btn-default").click(function() {
        $(".custom-label").removeClass("active"), $(this).addClass("active")
    });
    var e = document.getElementById("video-container");

    function t(e) {
        return !!/^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/.test(e)
    }
      $("#video-section").click(function() {
        $(this).find('i').hasClass("fa-pause") ? ($(this).find('i').removeClass("fa-pause"), $(this).find('i').addClass("fa-play"), e.pause()) : ($(this).find('i').removeClass("fa-play"), $(this).find('i').addClass("fa-pause"), e.play())
        $(".vid-controller").toggle()
    }), $(".stepwizard-step .btn").click(function() {
        "one" == $(this).attr("id") && ($("#two").removeClass("btn-primary"), $("#two").addClass("btn-default"), $(".form-one").show(500), $(".form-two").hide(500), $("#next").show(500))
    }), $("input[type=text]").keyup(function(event) {
        "" == $(this).val() ? ($(this).addClass("warning_red"), $(this).closest("div").find("p").remove(), $(this).closest("div").append('<p class="error-msg">This field is required.</p>')) : ($(this).removeClass("warning_red"), $(this).closest("div").find("p").remove());
        var e = $(this).attr("id"),
            s = $("#" + e).val();
        if ("sEmail" == e || "pcEmail" == e) {
            if (!t(s)) return $("#" + e).closest("div").find("p").remove(), $("#" + e).closest("div").append('<p class="error-msg">Invalid Email Address</p>'), !1;
            $("#" + e).closest("div").find("p").remove()
        }
        var npi = $(this).attr("id"),
            npiVal = $("#" + npi).val();
			
		if(npi=='npi')
        {
        if (npiVal.match(/^\d+$/)) { 
            if(npiVal.length!=10){
                $(this).addClass("warning_red");
               $(this).closest("div").find('p').remove();
               $(this).closest("div").append('<p class="error-msg">Enter 10 digit only</p>');
               return false;
            }
			if(!npiVal.match("^1")) {
			   $(this).addClass("warning_red");
               $(this).closest("div").find('p').remove();
               $(this).closest("div").append('<p class="error-msg">NPI number always starts with 1</p>');
               return false;
			 }
			else{
                $(this).removeClass("warning_red");
                $(this).closest("div").find('p').remove();
            }
                   
        }else{
            $("#" + npi).val('');
            $(this).closest("div").find('p').remove();
            $(this).closest("div").append('<p class="error-msg">Enter digit only</p>');
            return false;
        }
    
    }
	
	stat = $("#pcState").val();
	if(stat.length!=2){
	        $("#pcState").addClass("warning_red");
            $("#pcState").closest("div").find('p').remove();
            $("#pcState").closest("div").append('<p class="error-msg">State contains only two letters</p>');
            return false;
	}
	zip = $("#pcZip").val();
	if(zip.match(/^\d+$/)){
	
	if(zip.length==5 || zip.length==9 ){
	          $("#pcZip").removeClass("warning_red");
                $("#pcZip").closest("div").find('p').remove();
	}
	   else{
	         $("#pcZip").addClass("warning_red");
            $("#pcZip").closest("div").find('p').remove();
            $("#pcZip").closest("div").append('<p class="error-msg">Zip code only contains 5 or 9 digits</p>');
            return false;
               
            }
	}
    }), $("input[name=typeOfCancer]").click(function() {
        $(".cancer-type").remove()
    })
});