---
name: fzlbpms-karaf-bundles
description: >-
  Use this skill whenever modifying, building, deploying, debugging, or configuring
  Apache Karaf bundles, OSGi components, Blueprint XMLs, or Camel routes in the fzlbpms project.
  Guides the agent to always verify and alert whether the modified code requires redeployment to Karaf.
---

# FZLBPMS Apache Karaf Bundle Management & Deployment

This skill establishes standard operating procedures for developing, building, and deploying Apache Karaf OSGi bundles and Camel Blueprint contexts in the **fzlbpms** project.

---

## 1. The Core Rule: Mandatory Deploy Notification

Whenever the user or agent modifies code in the `fzlbpms` project:
> [!IMPORTANT]
> **Always explicitly evaluate and inform the user whether the changes require a deploy into Apache Karaf.**
> State clearly at the end of the task:
> * **"Deploy no Karaf: NECESSÁRIO"** (along with the command executed or required to deploy).
> * **"Deploy no Karaf: NÃO NECESSÁRIO"** (explaining why, e.g., only frontend, docs, or scripts were modified).

---

## 2. Directory Layout & Classification

| Directory | Type | Requires Karaf Deploy? | Action Needed |
| :--- | :--- | :--- | :--- |
| `src-projects/karaf_bundles/blueprint-osgi-camel-bundles/<bundle>/` | Java OSGi Camel Bundle | **SIM** | `mvn clean install` inside the bundle directory |
| `src-projects/karaf_bundles/blueprint-xmls-bundles/<context>.xml` | Blueprint XML Route | **SIM** | Copy XML to `src-projects/karaf_deploy_dir/` |
| `containers/fzl-karaf-camel-integration/custom_karaf_etc/` | Karaf Configuration | **SIM** | Restart Karaf container or reload config |
| `src-projects/karaf_deploy_dir/` | Hot-deploy folder | **SIM (Target)** | Monitored by Karaf for auto-deploy |
| `src-projects/fzlbpmsadmin-web/` | Web / Frontend | **NÃO** | Frontend build / reload |
| `documentation/`, `uml/`, `*.org` | Docs / Specs | **NÃO** | None |
| `bin/`, `ansible/`, `containers/` (others) | Scripts / Infra | **NÃO** (exceto Karaf etc) | Relevant container reload |

---

## 3. Deployment Workflows

### A. Java OSGi Bundles (`blueprint-osgi-camel-bundles`)
Examples: `bpmndrawer`, `chamadasonline`, `orbeonforms`, `evasaoescolar`, `tasktoday`.

1. **Build and install:**
   ```bash
   cd src-projects/karaf_bundles/blueprint-osgi-camel-bundles/<bundle-name>
   mvn clean install
   ```
2. **Auto-copy:** The bundle's `pom.xml` automatically copies the resulting `.jar` into:
   ```text
   src-projects/karaf_deploy_dir/<bundle-name>-<version>.jar
   ```
3. **Verify:** Check Karaf logs to confirm deployment.

### B. Blueprint XML Bundles (`blueprint-xmls-bundles`)
Examples: `keycloak-admin-camel-context.xml`, `moodle-admin-camel-context.xml`, `dir_input_file_processor_blueprint_camel_context.xml`.

1. **Copy to deploy dir:**
   ```bash
   cp src-projects/karaf_bundles/blueprint-xmls-bundles/<context>.xml src-projects/karaf_deploy_dir/
   ```
2. **Verify:** Karaf detects file change and restarts the Camel blueprint context automatically.

---

## 4. Verification & Diagnostics

Always verify bundle status after deployment:

1. **Check Karaf runtime logs:**
   ```bash
   ./bin/tail-karaf-log.sh
   ```
   Look for: `Bundle <name> [id] has been started` or Camel route start messages. Ensure no `BundleException` or Blueprint timeout occurred.

2. **Karaf Interactive Console:**
   ```bash
   ./bin/karaf-console.sh
   ```
   Common commands:
   * `bundle:list | grep -i <name>` -> Ensure state is `Active`.
   * `bundle:restart <id>` -> Force bundle reload if needed.
   * `bundle:diag <id>` -> Diagnose why a bundle is in `Resolved` or `GracePeriod` instead of `Active`.

3. **Web Console:**
   ```bash
   ./bin/karaf-webconsole.sh
   ```
   Opens Apache Karaf Web Console for visual monitoring.
