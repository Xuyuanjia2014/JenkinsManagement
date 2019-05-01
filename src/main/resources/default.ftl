<?xml version='1.0' encoding='UTF-8'?>
<maven2-moduleset plugin="maven-plugin@2.16">
    <actions/>
    <description></description>
    <keepDependencies>false</keepDependencies>
    <properties>
        <com.dabsquared.gitlabjenkins.connection.GitLabConnectionProperty plugin="gitlab-plugin@1.4.5">
            <gitLabConnection></gitLabConnection>
        </com.dabsquared.gitlabjenkins.connection.GitLabConnectionProperty>
        <jenkins.model.BuildDiscarderProperty>
            <strategy class="hudson.tasks.LogRotator">
                <daysToKeep>5</daysToKeep>
                <numToKeep>20</numToKeep>
                <artifactDaysToKeep>-1</artifactDaysToKeep>
                <artifactNumToKeep>-1</artifactNumToKeep>
            </strategy>
        </jenkins.model.BuildDiscarderProperty>
    </properties>
    <scm class="hudson.plugins.git.GitSCM" plugin="git@3.3.0">
        <configVersion>2</configVersion>
        <userRemoteConfigs>
            <hudson.plugins.git.UserRemoteConfig>
                <!-- https://github.com/Xuyuanjia2014/otcplatform.git -->
                <url>${gitURL}</url>
                <credentialsId></credentialsId>
            </hudson.plugins.git.UserRemoteConfig>
        </userRemoteConfigs>
        <branches>
            <hudson.plugins.git.BranchSpec>
                <name>*/master</name>
            </hudson.plugins.git.BranchSpec>
        </branches>
        <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
        <submoduleCfg class="list"/>
        <extensions>
            <hudson.plugins.git.extensions.impl.WipeWorkspace/>
        </extensions>
    </scm>
    <canRoam>true</canRoam>
    <disabled>false</disabled>
    <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
    <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
    <triggers/>
    <concurrentBuild>false</concurrentBuild>
    <rootModule>
        <groupId>com.isdream</groupId>
        <artifactId>otcplatform</artifactId>
    </rootModule>
    <rootPOM>pom.xml</rootPOM>
    <goals>clean install -Dmaven.test.skip=true</goals>
    <aggregatorStyleBuild>true</aggregatorStyleBuild>
    <incrementalBuild>false</incrementalBuild>
    <ignoreUpstremChanges>false</ignoreUpstremChanges>
    <ignoreUnsuccessfulUpstreams>false</ignoreUnsuccessfulUpstreams>
    <archivingDisabled>false</archivingDisabled>
    <siteArchivingDisabled>false</siteArchivingDisabled>
    <fingerprintingDisabled>false</fingerprintingDisabled>
    <resolveDependencies>false</resolveDependencies>
    <processPlugins>false</processPlugins>
    <mavenValidationLevel>-1</mavenValidationLevel>
    <runHeadless>false</runHeadless>
    <disableTriggerDownstreamProjects>false</disableTriggerDownstreamProjects>
    <blockTriggerWhenBuilding>true</blockTriggerWhenBuilding>
    <settings class="jenkins.mvn.DefaultSettingsProvider"/>
    <globalSettings class="jenkins.mvn.DefaultGlobalSettingsProvider"/>
    <reporters/>
    <publishers/>
    <buildWrappers/>
    <prebuilders>
        <hudson.plugins.sonar.SonarRunnerBuilder plugin="sonar@2.6.1">
            <project></project>
            <properties>
                sonar.projectKey=test
                sonar.projectName=test
                sonar.projectVersion=${BUILD_NUMBER}
                sonar.language=java
                sonar.sourceEncoding=UTF-8
                sonar.sources=src
                sonar.scm.provider=git
                #sonar.verbose=false
                #sonar.binaries=target/classes
                #sonar.java.binaries=target/classes
                #sonar.junit.reportsPath=target
                #sonar.java.coveragePlugin=jacoco
                #sonar.jacoco.reportPath=target/jacoco.exec
            </properties>
            <javaOpts></javaOpts>
            <additionalArguments></additionalArguments>
            <jdk>java-1.8</jdk>
            <task></task>
        </hudson.plugins.sonar.SonarRunnerBuilder>
        <hudson.tasks.Shell>
            <command></command>
        </hudson.tasks.Shell>
    </prebuilders>
    <postbuilders>
        <hudson.tasks.Shell>
            <command></command>
        </hudson.tasks.Shell>
    </postbuilders>
    <runPostStepsIfResult>
        <name>FAILURE</name>
        <ordinal>2</ordinal>
        <color>RED</color>
        <completeBuild>true</completeBuild>
    </runPostStepsIfResult>
</maven2-moduleset>