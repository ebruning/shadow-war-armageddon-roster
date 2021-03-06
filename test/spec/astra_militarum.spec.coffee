import Vue from 'vue'

describe 'the imperial guard roster', () ->

  it 'links to a faction roster', (done) ->
    @vm.$router.push 'build/astra_militarum'
    Vue.nextTick () =>
      expect(@words('h2')).toBe 'Astra Militarum Kill Team'
      done()

  it 'can add three specialists', (done) ->
    expect(@all('.chosen-fighter-card').length).toBe 0
    specButton = @all('.available-fighter-card button')[3]
    specButton.click()
    specButton.click()
    specButton.click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 3
      expect(@all('.chosen-fighter-card .fighter-name')[1].textContent).toBe 'Special Weapons Operative'
      done()

  it 'can equip carapace armour replacing flak armour', (done) ->
    wargear = @get('select.add-wargear')
    @change wargear, @option(wargear, 'Carapace armour')
    Vue.nextTick () =>
      expect(@all('.wargear-item').length).toBe 6
      expect(@all('.wargear-item')[1].textContent).toMatch /Carapace armour -\s*20 points/
      done()

  it 'can equip special weapons', (done) ->
    wargear = @get('select.add-wargear')
    expect(wargear.textContent).not.toContain 'Red-dot laser sight'
    @change wargear, @option(wargear, 'Sniper rifle')
    Vue.nextTick () =>
      expect(@all('.wargear-item')[2].textContent).toMatch /Sniper rifle -\s*40 points/
      expect(@get('select.add-wargear').textContent).toContain 'Red-dot laser sight'
      done()

  it 'can exit cleanly and return to home', (done) ->
    @get('a.router-link-active').click()
    Vue.nextTick () =>
      @all('.modal-footer button')[0].click()
      Vue.nextTick () =>
        expect(@words('h2')).toBe 'Create a New Roster'
        done()
