import Vue from 'vue'

describe 'the grey knights roster', () ->

  it 'links to a faction roster', (done) ->
    @vm.$router.push 'build/grey_knights'
    Vue.nextTick () =>
      expect(@words('h2')).toBe 'Grey Knights Kill Team'
      done()

  it 'can add a specialist', (done) ->
    @all('.available-fighter-card button')[2].click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 1
      wargear = @get('select.add-wargear')
      @change wargear, @option(wargear, 'Psilencer')
      Vue.nextTick () =>
        expect(@all('.wargear-item').length).toBe 2
        expect(@all('.wargear-item')[0].textContent).toContain 'Power armour'
        expect(@all('.wargear-item')[1].textContent).toMatch /Psilencer -\s*150 points/
        done()

  it 'can exit cleanly and return to home', (done) ->
    @get('a.router-link-active').click()
    Vue.nextTick () =>
      @all('.modal-footer button')[0].click()
      Vue.nextTick () =>
        expect(@words('h2')).toBe 'Create a New Roster'
        done()
