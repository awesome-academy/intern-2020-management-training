$(document).on('turbolinks:load', function () {
  //Config Ajax
  $.ajaxSetup({
    headers:
      {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')}
  });
  // End Config Ajax

  // Feature checkbox all
  let checkAll = $('#check-all');
  checkAll.on('change', function () {
    let listSubjects = $('#list-subjects input[type="checkbox"]');
    if ($(this).prop('checked')) {
      listSubjects.each(function (index, element) {
        $(element).prop('checked', true);
        $(element).next().val($(element).data('id'));
      })
    } else {
      listSubjects.each(function (index, element) {
        $(element).prop('checked', false);
        $(element).next().val(null);
      })
    }
  });
  // End Feature checkbox all

  // Topic and Subject
  let urlSearchSubject = $('#search-subject').data('url');
  $('#search-subject').on('click', function () {
    let topicId = '';
    let listSubject = [];

    $('#topic option').each(function (index, element) {
      if ($(element).prop('selected')) {
        topicId = $(element).val();
        return false;
      }
    });

    $('#list-subjects input[type="checkbox"]').each(function (index, element) {
      if($(element).prop('checked')) listSubject.push($(element).val());
    });

    $.ajax({
      url: urlSearchSubject,
      method: 'GET',
      data: {
        topic: topicId,
        ids: listSubject
      }
    });
  });

  $('#searchSubject').on('keydown', function (e) {
    if (e.which === 13) {
      let keyword = $(this).val();
      let topicId = '';
      $('#topic option').each(function (index, element) {
        if ($(element).prop('selected')) {
          topicId = $(element).val();
          return false;
        }
      });

      $.ajax({
        url: urlSearchSubject,
        method: 'GET',
        data: {
          query: keyword,
          topic: topicId
        }
      });
    }
  });

  $('#add-subject').on('click', function () {
    $('#other-list-subjects li').each(function (index, element) {
      if ($(element).children('input[type="checkbox"]').prop('checked')) {
        $(element).clone().appendTo('#list-subjects');
        $(element).remove();
      }
    });
  });
  //End Subject and Topic

  // Search Trainee
  let urlSearchTrainee = $('#btn-search-trainee').data('url');
  $('#searchTrainee').on('keydown', function (e) {
    if (e.which === 13) {
      let keyword = $(this).val();
      let ids = [];

      $('#list-trainee-added li input').each(function (index, element) {
        if($(element).val()) ids.push($(element).val())
      });

      $.ajax({
        url: urlSearchTrainee,
        method: 'GET',
        data: {
          query: keyword,
          ids: ids
        }
      });
    }
  });
  //End Search Trainee

  //Add trainee
  $('#list-trainee').on('click', 'li',function (element) {
    $('#list-trainee-added').append($(this));
  });
  //End Trainee

  $('body').on('change', '.select-subject', function () {
    if($(this).prop('checked')) {
      $(this).next().val($(this).data('id'));
    } else {
      $(this).next().val(null);
    }
  });
  //End Submit form
});
