$(document).ready(function () {
  $('input:radio[name="modification[type]"]')
    .each(function() {
      $(this).attr('data-target', $(this).val().replace('Modifications::','#'));
    })
    .click(function () {
      $(this).tab('show');
      $(this).removeClass('active');
      $('.tab-content').find('input').prop("disabled", true);
      $($(this).attr('data-target')).find('input').prop("disabled", false);
    });
  $('.form-group.type input:checked').click();
});
