$(function() {

	$('.link-row').click(function() {
		window.location = $(this).attr('id');
	});
	
	$('a.job-link[data-status="Closed"]').hide();
	
	$('#job-list-toggle button').click(function() {
		$('#job-list-toggle button').removeClass('active');
		$(this).addClass('active');
		var status = $(this).attr('data-toggle');
		$('a.job-link').hide();
		$('a.job-link[data-status="' + status + '"]').show();
		return false;
	});
			
});

$(function() {
  $(document).ready(function() {
    $('a.delete').click(function() {
      if (!confirm('This cannot be undone! Continue?')) {
        return false;
      }
    });
  });
}).call(this);

$(function() {
  $(document).ready(function() {
    $('button.delete').click(function() {
      if (!confirm('This cannot be undone! Continue?')) {
        return false;
      }
    });
  });
}).call(this);



// $(function() {
// 	$(document).ready(function(){
//  		setTimeout(function(){
//  			$('div#alert').fadeOut('slow', function() {
//  			$('div#alert').remove();
//  	      });
//  		}, 4000);
//  	});
// }).call(this);	
