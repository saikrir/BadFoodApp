	var initPage = function(){
		$("#ateWhen").datepicker(
		{
		  dateFormat: "yy-mm-dd",
		  buttonImageOnly: true,
		  buttonImage: "calendar.gif",
		  buttonText: "Calendar" 
		});
		
		$("form").on("submit", function() {
			var valid = false;
			
			var dishName = $("#dishName");
			var ateWhere = $("#ateWhere");
			var ateWhen = $("#ateWhen");
			var symptoms = $("#symptoms");
			var badIngredient = $("#badIngredient");
			var comments = $("#comments");
			
			valid = (validateField(dishName) &&
					validateField(ateWhere) &&
					validateField(ateWhen) && 
					validateDate(ateWhen) &&
					validateField(symptoms) &&
					validateField(badIngredient) &&
					validateField(comments));				
					
			return valid;
		});
	};
	
	var validateDate = function(dateField){
		var dateFieldValue = new Date(dateField.val());
		var today = new Date();
		if(dateFieldValue > today)
		{
			var label = dateField.prev();
			label.addClass("error");
			label.html("You can complain about future");
			dateField.addClass("error");
			return false;
		}
		return true;
	}
	
	var validateField = function(fieldName){
		var fieldValid = true;
		if($.trim(fieldName.val()) === ""){
			var label = fieldName.prev();
			fieldName.addClass("error");
			label.addClass("error");
			var labelTxt = label.val();
			label.val(labelTxt + "is required!");
			fieldValid = false;
		}
		return fieldValid;
	}
	
	
	initPage();