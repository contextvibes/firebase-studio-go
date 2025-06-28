---
title: "Playbook: The Scrum Process"
date: "2025-06-28T12:00:00Z"
lastmod: "2025-06-28T12:00:00Z"
draft: false
type: "playbook"
description: "The official guide to the Scrum process as implemented by the THEA team."
tags: ["playbook", "scrum", "process", "agile", "workflow"]
params:
  playbook_id: "PLAYBOOK-SCRUM-PROCESS"
  status: "Active"
---

# Playbook: The Scrum Process

## 1. Philosophy & Goals
This document defines the specific implementation of the Scrum framework for this project. Our primary goals are to maintain a predictable development rhythm, ensure high-quality output, and facilitate rapid learning and adaptation.

## 2. Core Components

### 2.1. Roles & Personas
The core roles for our team, including the **Orchestrator** and the specialized **AI Assistant Personas**, are defined in our **[Team Handbook](../reference/team-handbook.md)**, which serves as the single source of truth for all roles and responsibilities.

### 2.2. The Artifacts
- **Product Backlog:** The single source of truth for all work to be done on the project.
- **Sprint Backlog:** A set of Product Backlog items selected for a single Sprint.
- **Increment:** The sum of all Product Backlog items completed during a Sprint, which must be in a releasable state.

### 2.3. The Ceremonies
- **Sprint Planning:**
  - **When:** At the beginning of each new sprint.
  - **Goal:** To select a set of PBIs from the backlog and define a clear Sprint Goal.
  - **Process:** The Orchestrator and AI Assistant collaboratively agree on the sprint's scope and goal.

- **Daily Stand-up (Asynchronous):**
  - **When:** At the start of each work session.
  - **Goal:** To align on the immediate next steps.
  - **Process:** The Orchestrator states the current goal, and the AI provides the necessary commands or context to achieve it.

- **Sprint Review & Retrospective (Combined):**
  - **When:** At the end of each sprint.
  - **Goal:** To review the completed work and identify process improvements.
  - **Process:** The Orchestrator and AI review the "Definition of Done" for the sprint's PBIs and discuss what went well and what could be improved in the next sprint.

## 3. The Definition of Done (DoD)
A Product Backlog Item is considered "Done" only when:
- All associated code has been written and merged to `main`.
- All related documentation has been updated.
- All acceptance criteria specified in the PBI have been met and verified.
- The increment is potentially releasable.