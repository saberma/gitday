class Issue < ActiveRecord::Base
  belongs_to :repository
  has_many :comments, :class_name => 'IssueComment', extend: IssueComment::Extension
  attr_accessible :number, :title, :body

  module Extension

    def repo
      @association.owner
    end

    def get(number)
      issue = self.find_by_number(number)
      unless issue
        json = Octokit.issue(repo.fullname, number)
        issue = repo.issues.create({
          :number => number,
          :title => json['title'],
          :body => json['body']
        })
      end
      issue
    end
  end
end
