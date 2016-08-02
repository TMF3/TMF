{CompositeDisposable} = require 'atom'
spawn = require('child_process').spawn
console.log 'yo'
module.exports =
    subscriptions: null
    activate: ->
        @subscriptions = new CompositeDisposable
        @subscriptions.add atom.commands.add 'atom-workspace','buildme:build': => @build()


    deactivate: ->
        @subscriptions.dispose()
    build: ->
        startNotification = atom.notifications.addInfo ('Build Started'), dismissable: true, detail: 'Stand by ...'
        path = atom.project.getPaths() + '\\build.exe'
        console.log path
        buildProcess = spawn(path,atom.project.getPaths())
        buildProcess.stderr.on 'data', (data) -> atom.notifications.addError ('Build Error'), dismissable: true, detail: data
        buildProcess.stdout.on 'data', (data) -> atom.notifications.addSuccess 'Development Build Passed', dismissable: true, detail: data
        buildProcess.stdout.on 'close', => startNotification.dismiss()
