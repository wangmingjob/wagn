class AdjustCardSummariesType < ActiveRecord::Migration
  def self.up
    execute "drop view card_summaries"
    execute %{
      CREATE VIEW card_summaries AS
      SELECT c.*, cr.content AS content, cr.revised_at AS revised_at,
        tr.name AS tag_name, t.node_id, 
      CASE
        WHEN n."type" IS NOT NULL THEN ( n."type"::text)::character varying
        ELSE t.node_type
      END AS node_type
      FROM cards c
      JOIN revisions cr ON cr.id = c.current_revision_id
      JOIN tags t ON t.id = c.tag_id
      JOIN tag_revisions tr ON tr.id = t.current_revision_id
      LEFT JOIN nodes n ON t.node_id = n.id AND t.node_type::text = 'Node::Base'::text;
    }  
  end

  def self.down
    execute "drop view card_summaries"
    execute %{
      CREATE VIEW card_summaries AS
      SELECT c.*, cr.content AS content, cr.revised_at AS revised_at,
        tr.name AS tag_name, t.node_id, 
      CASE
        WHEN n."type" IS NOT NULL THEN ('Node::'::text || n."type"::text)::character varying
        ELSE t.node_type
      END AS node_type
      FROM cards c
      JOIN revisions cr ON cr.id = c.current_revision_id
      JOIN tags t ON t.id = c.tag_id
      JOIN tag_revisions tr ON tr.id = t.current_revision_id
      LEFT JOIN nodes n ON t.node_id = n.id AND t.node_type::text = 'Node::Base'::text;
    }  
  end
end
