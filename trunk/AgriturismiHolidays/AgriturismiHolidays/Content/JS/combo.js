
function HierarchicalSelection() {
} 

HierarchicalSelection.prototype = {
	
	clearChild: function(child) {
		$(child).find('option:gt(0)').remove();
	},
	
	registerSelect: function(parent, child, urlParam, rootUrl, funcEvent){
		var parentSelect = "select[name='"+ parent +"']";
		var childSelect = "select[name='"+ child +"']";
		var mySelf = this;
		
		$(parentSelect).change(function(){
			
		  	var selected = $(parentSelect + " option:selected");			
		    var id = selected.val();
					
			if (id == undefined || id.length == 0) {
				mySelf.clearChild(childSelect);
				return;
			}
				
			$.ajax({
				type:"GET",

				url: rootUrl,
				
				data: urlParam +"="+ id,
				
				dataType:"json",
						
				success:function(data){
					
					var len = data.length - 1;
					if(data[len].error.isOnError) {
						mySelf.clearChild(childSelect);
						//TODO: Dom Alert
						alert("error:"+ data[len].error.message);
					} else {
						
						mySelf.clearChild(childSelect);
					
						var appended = false;
						$.each(data, function(index, obj){	
							if (obj.id != undefined) {								
								$(childSelect)
								.append($("<option></option>")
								.attr("value",obj.id).text(obj.value));
								
								appended = true;										
							}
						});
						
						if(appended)
							funcEvent();
					}					
				},
				
				error:function(msg, textStatus, errorThrown){
					alert("errore di comunicazione: "+ msg.status);
				}
			});
		  });
	}
	
}