export function scrollPaginator(){
  if ($('#subject-paginator .pagination').length && $('#list-subjects').length) {
    $(window).on('scroll', function(){
      let more_subjects_url = $('#subject-paginator .pagination a[rel]').attr('href');
      if(more_subjects_url) {
        more_subjects_url = more_subjects_url;
      } else {
        more_subjects_url= $('#subject-paginator .pagination .next a').attr('href');
      }
      if (more_subjects_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60) {
        $('#subject-paginator .pagination').html('<img src="/assets/widget-loader-lg-en.gif" height="40" />');
        setTimeout(() => {
          $.getScript(more_subjects_url);
        }, 1000);
      }
    });
  }
}
