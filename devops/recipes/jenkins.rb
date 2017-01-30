## Jenkins provisioning
node.default['jenkins']['master']['jvm_options'] = '-Djenkins.install.runSetupWizard=false'
include_recipe "jenkins::java"
include_recipe "jenkins::master"

jenkins_plugin 'matrix-auth'
jenkins_plugin 'credentials'
jenkins_plugin 'mailer'
jenkins_plugin 'ssh-credentials'
jenkins_plugin 'ssh-slaves'

jenkins_script 'add_authentication' do
  command <<-EOH.gsub(/^ {4}/, '')

  import jenkins.model.*
  import hudson.security.*

  def instance = Jenkins.getInstance()

  def hudsonRealm = new HudsonPrivateSecurityRealm(false)
  hudsonRealm.createAccount("admin","sar1tasa")
  instance.setSecurityRealm(hudsonRealm)
  def strategy = new hudson.security.FullControlOnceLoggedInAuthorizationStrategy()
  strategy.setAllowAnonymousRead(false)
  instance.setAuthorizationStrategy(strategy)

  instance.save()

  EOH
end
