class this.ThemesBuilder
	constructor: (params) ->
		@theme_preview = '#theme-preview'
		@theme_editor = '#theme-editor'

		$(document).on 'change', '#theme-select', (el) =>
			_el = $(el.currentTarget)
			@apply_theme(_el.val())

		$('#theme-select').change()

	apply_theme: (id) ->
		$("#{@theme_preview} iframe").attr('src', "/theme_preview?theme_id=#{id}")