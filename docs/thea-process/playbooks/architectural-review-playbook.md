---
title: "Playbook: AI-Led Architectural Reviews"
date: 2025-06-28T11:50:00Z
lastmod: 2025-06-28T11:50:00Z
draft: false
type: "playbook"
description: "A playbook for conducting structured, AI-led architectural reviews to ensure technical decisions are sound and well-documented."
tags: ["playbook", "architecture", "process", "ai-collaboration", "5ws"]
---
# Playbook: AI-Led Architectural Reviews

## 1. Philosophy and Goal

This playbook outlines a structured process for conducting architectural reviews, where an AI assistant acts as the interviewer and a human project lead acts as the subject matter expert.

The goal is to ground all technical decisions in business purpose *before* implementation, and to produce a comprehensive architecture document as a result of the process.

## 2. The AI-Led Interview Process

This process is designed to be a collaborative discovery session.

1.  **Initiation:** The Orchestrator (human lead) requests an architectural review for a specific epic or feature.
2.  **Methodology Selection:** The AI Assistant asks the Orchestrator which review framework to use. The default and recommended framework is the "5Ws Framework" detailed below.
3.  **Structured Questioning:** The AI proceeds through the selected framework, asking questions sequentially.
4.  **The Challenger Stance (CRITICAL):** The AI Assistant **MUST NOT** passively accept answers. It must:
    *   **Be Persistent:** If a question is only partially answered, politely restate the unanswered portion and ask for more detail.
    *   **Challenge Inconsistencies:** If a statement contradicts previous statements or project context, the AI must point out the contradiction and seek clarification.
    *   **Request Specifics:** The AI should push for specific implementation details over vague concepts (e.g., "How is it triggered?" instead of accepting "It runs periodically").
5.  **Synthesis:** After the interview, the AI synthesizes all gathered information into a formal Architecture Document.

## 3. The 5Ws Framework

This is the primary methodology for conducting the review.

### Part 1: The "Why" - Business Purpose & Functional Goals
- **Key Question:** Why does this system need to exist?
- **Goal:** To understand the core business problem, value proposition, and success metrics.

### Part 2: The "Who" - Users, Stakeholders, and Systems
- **Key Question:** Who (or what) interacts with this system?
- **Goal:** To identify all human users, consuming systems, and external data sources.

### Part 3: The "How" - High-Level Architecture & Data Flow
- **Key Question:** How does the system achieve its goal at a high level?
- **Goal:** To sketch out the primary components and the flow of data between them.

### Part 4: The "What" - Deep Dive into Key Components & Technologies
- **Key Question:** What specific technologies and patterns will be used?
- **Goal:** To detail the tech stack, libraries, cloud services, and architectural patterns.

### Part 5: The "Where & When" - Deployment, Operations & Lifecycle
- **Key Question:** Where will this system run and when will it be triggered?
- **Goal:** To understand the deployment environment, CI/CD, operational triggers, and monitoring strategy.