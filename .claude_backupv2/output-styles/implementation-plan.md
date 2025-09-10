---
name: implementation-plan
description: Structured planning and task breakdown format for development work
---

# Implementation Plan Output Style

Standardized format for development planning, task breakdown, and implementation roadmaps with clear delegation strategies.

## Plan Structure

### Plan Overview
- **Plan Title**: {{plan_title}}
- **Objective**: {{primary_objective}}
- **Created**: {{timestamp}}
- **Estimated Duration**: {{estimated_duration}}
- **Complexity**: {{complexity_level}} (Low/Medium/High)
- **Delegation Strategy**: {{delegation_approach}}

### 🎯 **Objective & Scope**

#### Primary Objective
{{primary_objective_detailed}}

#### Success Criteria
{{#each success_criteria}}
- ✅ **{{criteria}}**: {{description}}
{{/each}}

#### Scope Definition
**In Scope:**
{{#each in_scope_items}}
- {{item}}
{{/each}}

**Out of Scope:**
{{#each out_scope_items}}
- {{item}}
{{/each}}

### 📋 **Implementation Tasks**

#### Phase 1: {{phase_1_name}} ({{phase_1_duration}})
{{#each phase_1_tasks}}
**{{task_number}}. {{task_name}}**
- **Description**: {{task_description}}
- **Acceptance Criteria**: {{acceptance_criteria}}
- **Estimated Effort**: {{effort_estimate}}
- **Dependencies**: {{dependencies}}
- **Delegation**: {{delegation_strategy}}
  {{#if agent_assignment}}
  - **Agent**: {{agent_name}}
  - **Context**: {{agent_context}}
  - **Tools**: {{agent_tools}}
  {{/if}}
{{/each}}

#### Phase 2: {{phase_2_name}} ({{phase_2_duration}})
{{#each phase_2_tasks}}
**{{task_number}}. {{task_name}}**
- **Description**: {{task_description}}
- **Acceptance Criteria**: {{acceptance_criteria}}
- **Estimated Effort**: {{effort_estimate}}
- **Dependencies**: {{dependencies}}
- **Delegation**: {{delegation_strategy}}
{{/each}}

{{#if phase_3_exists}}
#### Phase 3: {{phase_3_name}} ({{phase_3_duration}})
{{#each phase_3_tasks}}
**{{task_number}}. {{task_name}}**
- **Description**: {{task_description}}
- **Acceptance Criteria**: {{acceptance_criteria}}
- **Estimated Effort**: {{effort_estimate}}
{{/each}}
{{/if}}

### 🤖 **Agent Delegation Strategy**

#### Primary Agent Responsibilities
- **Main Agent**: {{main_agent_role}}
  - **Focus**: {{main_agent_focus}}
  - **Tasks**: {{main_agent_tasks}}
  - **Context Management**: {{context_management}}

#### Subagent Assignments
{{#each subagent_assignments}}
**{{agent_name}}** ({{agent_type}})
- **Specialization**: {{specialization}}
- **Assigned Tasks**: {{assigned_tasks}}
- **Context Requirements**: {{context_requirements}}
- **Tools Allowed**: {{tools_allowed}}
- **Success Criteria**: {{agent_success_criteria}}
- **Integration Points**: {{integration_points}}
{{/each}}

#### Background Task Candidates
{{#each background_tasks}}
- **{{task_name}}**: {{task_description}}
  - **Reason for Background**: {{background_reason}}
  - **Expected Duration**: {{expected_duration}}
  - **Monitoring Strategy**: {{monitoring_approach}}
{{/each}}

### ⚠️ **Risk Assessment**

#### High Risk Areas
{{#each high_risks}}
**{{risk_name}}**
- **Impact**: {{impact_level}} (High/Medium/Low)
- **Probability**: {{probability}}
- **Mitigation**: {{mitigation_strategy}}
- **Contingency**: {{contingency_plan}}
{{/each}}

#### Medium Risk Areas  
{{#each medium_risks}}
- **{{risk_name}}**: {{description}} (Mitigation: {{mitigation}})
{{/each}}

#### Dependencies & Blockers
{{#each dependencies}}
- **{{dependency_name}}**: {{description}}
  - **Type**: {{dependency_type}}
  - **Resolution**: {{resolution_approach}}
  - **Impact if Delayed**: {{delay_impact}}
{{/each}}

### 🔄 **Rollback Strategy**

#### Rollback Triggers
{{#each rollback_triggers}}
- {{trigger_condition}}
{{/each}}

#### Rollback Steps
{{#each rollback_steps}}
{{step_number}}. **{{step_name}}**
   - **Action**: {{rollback_action}}
   - **Validation**: {{validation_method}}
   - **Time Required**: {{rollback_time}}
{{/each}}

#### Recovery Plan
- **Data Recovery**: {{data_recovery_plan}}
- **System Recovery**: {{system_recovery_plan}}
- **Communication**: {{recovery_communication}}

### 📊 **Progress Tracking**

#### Milestones
| Milestone | Target Date | Success Criteria | Status |
|-----------|-------------|------------------|--------|
{{#each milestones}}
| {{milestone_name}} | {{target_date}} | {{criteria}} | {{status}} |
{{/each}}

#### Key Performance Indicators
{{#each kpis}}
- **{{kpi_name}}**: {{current_value}} / {{target_value}} ({{unit}})
{{/each}}

#### Progress Reporting
- **Update Frequency**: {{update_frequency}}
- **Report Format**: {{report_format}}
- **Stakeholder Updates**: {{stakeholder_communication}}

### 🧪 **Testing Strategy**

#### Test Levels
{{#each test_levels}}
**{{test_level}}**
- **Coverage**: {{coverage_target}}
- **Tools**: {{testing_tools}}
- **Automation**: {{automation_level}}
- **Criteria**: {{pass_criteria}}
{{/each}}

#### Quality Gates
{{#each quality_gates}}
- **{{gate_name}}**: {{gate_criteria}}
  - **Tools**: {{gate_tools}}
  - **Pass Threshold**: {{pass_threshold}}
{{/each}}

### 🚀 **Deployment Plan**

#### Deployment Phases
{{#each deployment_phases}}
**{{phase_name}}** ({{deployment_date}})
- **Environment**: {{target_environment}}
- **Components**: {{components_deployed}}
- **Validation**: {{validation_approach}}
- **Rollback Time**: {{rollback_window}}
{{/each}}

#### Environment Preparation
{{#each environment_requirements}}
- **{{environment_name}}**: {{requirements}}
{{/each}}

### 📝 **Communication Plan**

#### Stakeholder Updates
{{#each stakeholder_groups}}
- **{{stakeholder_group}}**: {{update_frequency}} ({{communication_method}})
{{/each}}

#### Status Reporting
- **Daily Standup**: {{standup_format}}
- **Weekly Status**: {{weekly_report_format}}
- **Milestone Reports**: {{milestone_report_format}}

### 🔍 **Review & Retrospective**

#### Review Points
{{#each review_points}}
- **{{review_name}}**: {{review_date}}
  - **Participants**: {{participants}}
  - **Agenda**: {{agenda_items}}
  - **Deliverables**: {{deliverables}}
{{/each}}

#### Success Metrics
{{#each success_metrics}}
- **{{metric_name}}**: {{measurement_method}} (Target: {{target_value}})
{{/each}}

#### Lessons Learned Template
- **What Went Well**: [To be filled during retrospective]
- **Challenges Faced**: [To be filled during retrospective]  
- **Improvements for Next Time**: [To be filled during retrospective]

### Plan Metadata

- **Plan Version**: {{plan_version}}
- **Last Updated**: {{last_updated}}
- **Created By**: {{created_by}}
- **Approved By**: {{approved_by}}
- **Next Review**: {{next_review_date}}

---

**Implementation Readiness**: {{implementation_readiness_status}}

**Key Next Actions**: {{immediate_next_actions}}

**R&D Strategy**: This plan implements proper Reduce & Delegate framework with clear agent assignments and context management for scalable development.