"""empty message

Revision ID: d100af14fb12
Revises: 4bef87870cf7
Create Date: 2016-02-03 14:35:07.028802

"""

# revision identifiers, used by Alembic.
revision = 'd100af14fb12'
down_revision = '4bef87870cf7'

from alembic import op
import sqlalchemy as sa


def upgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.add_column('person', sa.Column('description', sa.Unicode(), nullable=True))
    ### end Alembic commands ###


def downgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('person', 'description')
    ### end Alembic commands ###
