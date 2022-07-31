// $(window).load(function() {
//   $('a[rel="popover"]').hover(function() {
//     return $(this).popover('toggle');
//   });
//   $('div.link').click(function() {
//     if ($(this).attr('target') === '_blank') {
//       return window.open($(this).attr('data-url'));
//     } else {
//       return window.location = $(this).attr('data-url');
//     }
//   });
//   return $('a#reset-password').click(function() {
//     return $('a#reset-password').attr('href', "/reset-password/" + ($('input#email').val()));
//   });
// });
//
// }).call(this);


// $(function() {
//
// 	$('.link-row').click(function() {
// 		window.location = $(this).attr('id');
// 	});
//
// 	$('a.job-link[data-status="Closed"]').hide();
//
// 	$('#job-list-toggle button').click(function() {
// 		$('#job-list-toggle button').removeClass('active');
// 		$(this).addClass('active');
// 		var status = $(this).attr('data-toggle');
// 		$('a.job-link').hide();
// 		$('a.job-link[data-status="' + status + '"]').show();
// 		return false;
// 	});
//
// });

// $(function() {
//   $(document).ready(function() {
//     $('a.delete').click(function() {
//       if (!confirm('This cannot be undone! Continue?')) {
//         return false;
//       }
//     });
//   });
// }).call(this);
//
// $(function() {
//   $(document).ready(function() {
//     $('button.delete').click(function() {
//       if (!confirm('This cannot be undone! Continue?')) {
//         return false;
//       }
//     });
//   });
// }).call(this);


