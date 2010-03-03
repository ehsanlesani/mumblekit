
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

				url: rootUrl +"/"+ id,
				
				//data: urlParam +"="+ id,
				
				dataType:"json",
						
				success:function(data){											
					mySelf.clearChild(childSelect);
				
					var appended = false;
					$.each(data, function(index, obj){	
						if (obj.Id != undefined) {								
							$(childSelect)
							.append($("<option></option>")
							.attr("value",obj.Id).text(obj.Value));
							
							appended = true;										
						}						
					});
					
					if(appended)
						funcEvent();
				},
				
				error:function(msg, textStatus, errorThrown){
					alert("errore di comunicazione: "+ msg.status);
				}
			});
		  });
	}
	
}